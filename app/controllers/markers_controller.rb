class MarkersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_restaurant
  
  def new 
    @marker = Marker.new
  end

  def create
    @marker = @restaurant.markers.build(marker_params)
    
    if @marker.save
      redirect_to @restaurant, notice: "Marcador salvo com sucesso"
    else
      flash.now[:notice] = "Erro ao salvar marcadores"
      render :new, status: :unprocessable_entity
    end

  end

  private 

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def marker_params
    params
    .require(:marker)
    .permit(
      :name,
      :restaurant_id
    )
  end

end