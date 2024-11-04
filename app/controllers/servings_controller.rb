class ServingsController < ApplicationController
  before_action :set_menu_item
  before_action :set_serving, only: [:edit, :update]

  def new
    @serving = Serving.new
  end

  def create
    @serving = @menu_item.servings.build(serving_params)

    if @serving.save
      redirect_to [@restaurant, @menu_item], notice: "Cadastrado com sucesso"
    else
      puts @serving.errors.full_messages
      flash.now[:alert] = "Não foi possível realizar o cadastro"
      render :new
    end
  end

  def edit
  end

  def update
    if @serving.update(serving_params)
      redirect_to [@restaurant, @menu_item], notice: "Porção atualizada com sucesso"
    else
      puts @serving.errors.full_messages
      flash.now[:alert] = "Não foi possível atualizar a porção"
      render :edit
    end
  end

  private

  def set_serving
    @serving = Serving.find(params[:id])
  end

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