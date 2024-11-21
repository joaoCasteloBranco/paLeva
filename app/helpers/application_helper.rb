module ApplicationHelper

  def render_home
    if user_signed_in?
      render 'shared/home/user_home'
    elsif employee_signed_in?
      render 'shared/home/employee_home'
    else
      render 'shared/home/default_home'
    end
  end

  def render_nav
    if user_signed_in?
      render 'shared/nav/user_nav'
    elsif employee_signed_in?
      render 'shared/nav/employee_nav'
    else
      render 'shared/nav/default_nav'
    end
  end

end
