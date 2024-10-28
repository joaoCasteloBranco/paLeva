class RestaurantsController < ApplicationController

  def new
    @restaurant = Restaurants.new
  end

  def create
  end 
end
