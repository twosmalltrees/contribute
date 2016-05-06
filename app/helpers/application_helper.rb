module ApplicationHelper

  def contributor_signed_in?
    if @current_contributor
      true
    else
      false
    end
  end

end
