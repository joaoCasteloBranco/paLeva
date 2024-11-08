class MenusController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = Menu.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])

    menus_params = params
    .require(:menu)
    .permit(
      :name
    )

    @menu = @restaurant.menus.new(menus_params)

    if @menu.save
      redirect_to root_path, notice: "Cardápio criado com sucesso"
    else
      flash.now[:notice] = "falha ao criar o cardápio"
      render :new , status: :unprocessable_entity
    end
    
  end
end