class ReviewsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:create]


  def create
    review = Review.new(contributor_id: @current_contributor.id, comment_id: params[:comment_id], result: params[:review_result] )
    if review.save()
      comment = Comment.find(review.comment_id)
      comment.review_count += 1

      # Update comment review stats
      if review.result == "accepted"
        comment.accepted_review_streak += 1
      else
        comment.accepted_review_streak = 0
      end

      # Determine if comment status change required
      if comment.accepted_review_streak == 3
        comment.status = "approved"
        puts "HEEEEEERE ALL DETAILS BOUT STUFF"
        contributor = comment.contributor
        puts contributor
        contributor.reputation += 10
        puts contributor.reputation
        contributor.save
        puts contributor
      end

      if comment.review_count >= 5 && status == "pending"
        comment.status = "blocked"
        contributor = comment.contributor
        contributor.reputation -= 50
        contributor.save
      end

      comment.save

      render json: review
    else
      render json: {status: "failure"}
    end
  end

end
