class SearchController < ApplicationController
  before_action :authenticate_user!
  before_action :set_restaurant
  
  def search
    query = "%#{params[:query].downcase}%"
    @dishes = @restaurant.dishes.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", query, query)
    @beverages = @restaurant.beverages.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", query, query)
  end

  def set_restaurant
    @restaurant = current_user.restaurant
  end
end