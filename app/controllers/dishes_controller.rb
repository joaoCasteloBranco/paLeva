class DishesController < ApplicationController
  before_action :set_restaurant
  before_action :authorize_dish!, only: [:show]

  def index
    @dishes = @restaurant.dishes
  end

  def show
    @dish = @restaurant.dishes.find(params[:id])
  end

  def new
    @dish = @restaurant.dishes.build
  end

  def create
    @dish = @restaurant.dishes.build(dish_params)
    if @dish.save
      redirect_to @restaurant, notice: 'Prato Criado com sucesso!'
    else
      flash.now[:notice] = "Não foi possível cadastrar o prato!"
      render :new
    end
  end

  def edit
    @dish = @restaurant.dishes.find(params[:id])
  end

  def update
    @dish = @restaurant.dishes.find(params[:id])
    if @dish.update(dish_params)
      redirect_to restaurant_dish_path(@restaurant, @dish), notice: 'Prato atualizado com sucesso!'
    else
      render :edit
    end
  end

  def destroy
    @dish = @restaurant.dishes.find(params[:id])
    @dish.destroy
    redirect_to restaurant_path(@restaurant), notice: 'Prato excluído com sucesso!'
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def dish_params
    params
    .require(:dish)
    .permit(
    :name,
    :description,
    :calories,
    :photo
    )
  end

  def authorize_dish!
    unless @restaurant.user_id == current_user.id
      redirect_to root_path, alert: 'Acesso negado!'
    end
  end
end
  