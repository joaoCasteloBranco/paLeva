class ServingsController < ApplicationController
  before_action :set_menu_item

  def new
    @serving = Serving.new
  end

  def create
    @serving = @menu_item.servings.build(serving_params)

    if @serving.save
      redirect_to [@restaurant, @menu_item], notice: "Porção cadastrada com sucesso"
    else
      puts @serving.errors.full_messages
      flash.now[:alert] = "Não foi possível cadastar a porção"
      render :new
    end


  end

  private

  def set_menu_item
    @restaurant = Restaurant.find(params[:restaurant_id])
    if params[:dish_id]
      @menu_item = Dish.find(params[:dish_id])
    elsif params[:beverage_id]
      @menu_item = Beverage.find(params[:beverage_id])
    else
      redirect_to root_path, alert: 'Erro ao adicionar porção'
    end
  end

  def serving_params
    serving_params = params
    .require(:serving)
    .permit(
      :description,
      :price
    )
  end


  
end