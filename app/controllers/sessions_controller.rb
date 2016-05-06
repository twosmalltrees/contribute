class SessionsController < ApplicationController

  def new
    if host_user_signed_in?
      flash[:alert] = "You're currently signed in as a Host User. Please sign out before attempting to sign in as a Contributor."
      redirect_to root_path
    else
      render :new
    end
  end

  def create

    # Find contributor by email or username
    if params[:username_or_email].include? "@"
      contributor = Contributor.find_by_email(params[:username_or_email])
    else
      contributor = Contriutor.find_by_username(params[:username_or_email])
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


  def destroy
    session[:contributor_id] = nil
    flash[:notice] = "You have been successfully signed out."
    redirect_to root_path
  end

end
