class MarkersController < ApplicationController

  def new 
    @restaurant = Restaurant.find(params[:restaurant_id])
    @marker = Marker.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])

    marker_params = params
    .require(:marker)
    .permit(
      :name,
      :restaurant_id
    )

    @marker = @restaurant.markers.build(marker_params)
    
    if @marker.save
      redirect_to @restaurant, notice: "Marcador salvo com sucesso"
    else
      puts @marker.errors.full_messages
      flash.now[:notice] = "Erro ao salvar marcadores"
      render :new, status: :unprocessable_entity
    end

  end

end