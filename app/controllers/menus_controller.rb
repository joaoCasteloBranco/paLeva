class MenusController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = Menu.new
  end
end