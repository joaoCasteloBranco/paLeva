class ServingsController < ApplicationController

  def new
    @dish = Dish.find(params[:dish_id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    @serving = Serving.new

  end

  
end