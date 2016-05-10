class ReviewsController < ApplicationController

  def create

    render json: {this_will:"respond to a review submission"}
  end

  # create_table "reviews", force: :cascade do |t|
  #   t.datetime "created_at",     null: false
  #   t.datetime "updated_at",     null: false
  #   t.integer  "comment_id",     null: false
  #   t.integer  "contributor_id", null: false
  # end

end
