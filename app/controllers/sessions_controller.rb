class SessionsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:create_remote, :destroy_remote, :remote_current_contributor]

  def new
    if host_user_signed_in?
      flash[:alert] = "You're currently signed in as a Host User. Please sign out before attempting to sign in as a Contributor."
      redirect_to root_path
    else
      render :new
    end
  end

  def create
      # REGULAR, NON AJAX SIGN IN
      # Find contributor by email or username
      if params[:username_or_email].include? "@"
        contributor = Contributor.find_by_email(params[:username_or_email])
      else
        contributor = Contributor.find_by_username(params[:username_or_email])
      end

      # Check that contributor exists, and authenticate with password
        if contributor.present? && contributor.authenticate(params[:password])
          # Log them in
          session[:contributor_id] = contributor.id
          flash[:notice] = "You have been signed in successfully."
          redirect_to root_path
        else
          # Redirect back to Sign In with flash error
          flash[:alert] = "Invalid credentials, please try again."
          redirect_to contributor_sign_in_path
        end

  end

  def remote_current_contributor
    puts "REQUEST FOR CURRENT CONTRIBUTOR"
    puts @current_contributor
    render json: @current_contributor
  end

  def create_remote

    if params[:username_or_email].include? "@"
      contributor = Contributor.find_by_email(params[:username_or_email])
    else
      contributor = Contributor.find_by_username(params[:username_or_email])
    end

    if contributor.present? && contributor.authenticate(params[:password])
      # Log them in
      puts "CONTRIBUTOR WAS PRESENT"
      session[:contributor_id] = contributor.id
      puts session[:contributor_id]
      render json: contributor
    else
      puts "CONTRIBUTOR WASNT PRESENT"
      render json: contributor
    end

  end

  def destroy
    session[:contributor_id] = nil
    flash[:notice] = "You have been successfully signed out."
    redirect_to root_path
  end

  def destroy_remote
    session[:contributor_id] = nil
    render json: {sign_out: true}
  end

end
