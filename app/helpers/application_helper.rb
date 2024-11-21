module ApplicationHelper

  def render_home
    if user_signed_in?
      render 'shared/user_home'
    elsif employee_signed_in?
      render 'shared/employee_home'
    else
      render 'shared/default_home'
    end
  end
end
