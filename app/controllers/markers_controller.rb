class MarkersController < ApplicationController

  def new 
    @restaurant = Restaurant.find(params[:restaurant_id])
    @marker = Marker.new
  end

end