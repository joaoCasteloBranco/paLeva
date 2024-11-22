class DiscountsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @discount = Discount.new
  end
end