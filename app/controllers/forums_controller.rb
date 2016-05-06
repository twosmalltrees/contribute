class ForumsController < ApplicationController

  before_action :authenticate_host_user!

  def index
    @forums = current_host_user.forums
  end

end
