class DiscussionsController < ApplicationController

  def index
    # @forum = Forum.find_by(params[:forum_id])
    # @discussions = @forum.discussions
  end

  def show
    @forum = Forum.find(params[:forum_id])
    @discussion = Discussion.find(params[:id])
    @comments = @discussion.comments.all.order(created_at: :desc)
  end

  def new
  end

end
