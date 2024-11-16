class HomeController < ApplicationController
  before_action :set_restaurant_and_menus, only: :index
  
  def index

  end

  private

  def set_restaurant_and_menus
    user = current_user || current_employee
    return unless user.present? && user.restaurant.present?
    
    @restaurant = user.restaurant
    @menus = @restaurant.menus
  end
end
