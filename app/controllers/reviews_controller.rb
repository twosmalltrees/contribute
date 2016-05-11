class ReviewsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:create]


  def create
    review = Review.new(contributor_id: @current_contributor.id, comment_id: params[:comment_id], result: params[:review_result] )
    if review.save()
      render json: review
    else
      render json: {status: "failure"}
    end
  end

  # create_table "reviews", force: :cascade do |t|
  #   t.datetime "created_at",     null: false
  #   t.datetime "updated_at",     null: false
  #   t.integer  "comment_id",     null: false
  #   t.integer  "contributor_id", null: false
  # end

end
