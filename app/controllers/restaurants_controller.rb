class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end


  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    restaurant_params = params
    .require(:restaurant)
    .permit(
      :registered_name,
      :comercial_name,
      :cnpj,
      :address,
      :phone,
      :email
    )
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    if @restaurant.save!
      redirect_to @restaurant, notice: "Restaurante cadastrado!"
    else
      flash.now[:notice] = "Não foi possível registrar o restaurante"
      render :new
    end
  end 

  def show
    params_id = params[:id]
    @restaurant = Restaurant.find(params_id)
  end
end
