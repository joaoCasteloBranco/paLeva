class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_to_restaurant_creation_if_needed, if: :user_signed_in?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :cpf])
  end

  def after_sign_up_path_for(resource)
    new_restaurant_path
  end

  def redirect_to_restaurant_creation_if_needed
    unless current_user&.restaurant.nil?
      return
    end

    unless request.path.in?([destroy_user_session_path, restaurants_path, new_restaurant_path])
      redirect_to new_restaurant_path
    end
  end
end
