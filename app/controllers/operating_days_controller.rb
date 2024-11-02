class  OperatingDaysController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @operating_day = OperatingDay.new
  end

  def create
  end

end