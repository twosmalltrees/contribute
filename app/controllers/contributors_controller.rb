class ContributorsController < ApplicationController
  def new
    @contributor = Contributor.new
  end

  def create
    @contributor = Contributor.new(contributor_params)

    if @contributor.save
      flash[:notice] = 'You have successfully signed up. Welcome to Contribute!'
      session[:contributor_id] = @contributor.id
      redirect_to contributor_path(@contributor)
    else
      render :new
    end
  end

  def show
    @contributor = Contributor.find(params[:id])
  end

  private

  def contributor_params
    params.require(:contributor).permit(:username, :email, :password, :password_confirmation)
  end

end
