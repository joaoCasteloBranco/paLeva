class ServingsController < ApplicationController

  def new
    @dish = Dish.find(params[:dish_id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    @serving = Serving.new

  end

  def create
    @dish = Dish.find(params[:dish_id])
    @restaurant = Restaurant.find(params[:restaurant_id])

    serving_params = params
    .require(:serving)
    .permit(
      :description,
      :price
    )

    @serving = @dish.servings.build(serving_params)

    if @serving.save
      redirect_to restaurant_dish_path(@restaurant, @dish), notice: "Porção cadastrada com sucesso"
    else
      puts @serving.errors.full_messages
      flash.now[:alert] = "Não foi possível cadastar a porção"
      render :new
    end


  end

  
end