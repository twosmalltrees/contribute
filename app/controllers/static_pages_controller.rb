class StaticPagesController < ApplicationController

  def home
    if current_host_user
      redirect_to forums_path
    else
      redirect_to sign_in_prompt_path
    end
  end

  def sign_in_prompt
  end

end
