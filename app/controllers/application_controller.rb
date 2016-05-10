class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :fetch_contributor

  private

  def fetch_contributor
    @current_contributor = Contributor.find_by(id: session[:contributor_id]) if session[:contributor_id].present?
    session[:contributor_id] = nil unless @current_contributor.present?
  end

  def redirect_if_contributor_signed_in
    if @current_contributor
      flash[:alert] = "You're currently signed in as a Contributor. Please sign out before attempting to sign in as  a Host User"
      redirect_to root_path and return
    end
  end

end
