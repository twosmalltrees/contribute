class CommentsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:create]

  def index
   forum = Forum.find_by_root_domain( request.headers['origin'] )
   if forum
     discussion = Discussion.find_by_page_url( request.referer )
     if discussion
       @comments = discussion.comments.order(created_at: :asc)
       render json: @comments.as_json(only: [:body_text, :created_at_readable, :id, :status], include: { contributor: {only: :username} })
     else
       newDiscussion = Discussion.new(forum_id: forum.id, page_url: request.referer)
       if newDiscussion.save
         @comments = newDiscussion.comments.order(created_at: :asc)
         render json: @comments.as_json(only: [:body_text, :created_at_readable, :id, :status], include: { contributor: {only: :username} })
       else
         render status: 500
       end
     end
   else
     render json: 'Forum Not Found', status: 404
   end
  end

  # Tests to check that there is a currently logged in user, and also determines if any contribute-submit-button
  # to community moderation is required on this submission.
  def request_submit_permission
    @comment_for_review = Comment.under_review.first
    is_signed_in = true if @current_contributor
    if @comment_for_review
      # If there's a comment in queue for review, return below
      render json: {
        contributor_signed_in: is_signed_in,
        review_required: true,
        comment_body: @comment_for_review.body_text,
        comment_id: @comment_for_review.id
      }
    else
      # If no commment in queue for review, return below
      render json: {
        contributor_signed_in: is_signed_in,
        review_required: false
      }
    end
  end

  def create
    currentDiscussion = Discussion.find_by_page_url( request.referer )

    comment = Comment.new(contributor_id: @current_contributor.id, discussion_id: currentDiscussion.id, body_text: params[:body_text], created_at_readable: Time.now.strftime("%B %-d %Y, %-l:%M%P"))

    # If the current contributor has a reputation over 100, the comment is automatically approved.
    if @current_contributor.reputation >= 100
      comment.status = "approved"
      @current_contributor.reputation += 10
      @current_contributor.save
    end

    if comment.save
      render json: comment.as_json(only: [:body_text, :created_at_readable, :id], include: { contributor: {only: [:username, :reputation]} })
    else
      render json: {status: "save failed"}
    end
  end
end

# create_table "comments", force: :cascade do |t|
#   t.datetime "created_at",                         null: false
#   t.datetime "updated_at",                         null: false
#   t.integer  "contributor_id",                     null: false
#   t.integer  "discussion_id",                      null: false
#   t.boolean  "pending",        default: true
#   t.boolean  "removed",        default: false
#   t.string   "status",         default: "pending"
#   t.boolean  "is_reply",       default: false
#   t.integer  "reply_to"
#   t.text     "body_text",                          null: false
# end
