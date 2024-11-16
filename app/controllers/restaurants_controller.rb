class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy, :show]

  def index
    @restaurants = Restaurant.all
  end


  def show
    @markers = @restaurant.markers
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_user.build_restaurant(restaurant_params)

    if @restaurant.save
      redirect_to @restaurant, notice: "Restaurante cadastrado!"
    else
      current_user.restaurant = nil
      flash.now[:notice] = "Não foi possível registrar o restaurante"
      render :new, status: :unprocessable_entity
    end
  end 

  def edit 
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: "Restaurante Atualizado com Sucesso"
    else 
      flash.now[:notice] = "Não foi possível atualizar o restaurante"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to new_restaurant_path, notice: 'Restaurante Excluido com Sucesso!'
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def authorize_user!
    redirect_to root_path, alert: "Acesso não autorizado." unless @restaurant.user == current_user
  end

  def restaurant_params
    params.require(:restaurant).permit(
      :registered_name,
      :comercial_name,
      :cnpj,
      :address,
      :phone,
      :email
    )
  end

end
