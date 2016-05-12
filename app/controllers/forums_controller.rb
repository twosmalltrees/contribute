class ForumsController < ApplicationController

  before_action :authenticate_host_user!

  def index
    @forums = current_host_user.forums
  end

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(forum_params)
    @forum.host_user_id = current_host_user.id
      if @forum.save
        flash[:notice] = 'Forum was successfully created.'
        redirect_to @forum
      else
        render :new
      end
  end

  def show
    @forum = current_host_user.forums.find(params[:id])
    @discussions = @forum.discussions
  end

  private

  def forum_params
    params.require(:forum).permit(:forum_shortname, :root_domain)
  end

end
