class HomeController < ApplicationController

  def index
    unless current_user.present? && current_user.restaurant.present?
      return      
    end 
    
    @restaurant = current_user.restaurant
    @menus = @restaurant.menus
  end
end