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

  def check_is_admin
    return redirect_to root_path, alert: 'Acesso negado!' if current_user.nil?
  end

  def authenticate_account!
    unless user_signed_in? || employee_signed_in?
      redirect_to new_user_session_path, alert: 'Você precisa estar autenticado para acessar esta página.'
    end
  end

end
