class MenusController < ApplicationController
  before_action :set_restaurant
  before_action :authenticate_user!
  before_action :authorize_menu!, only: [:show, :new ]

  def show
    @menu = Menu.find(params[:id])
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = @restaurant.menus.new(menus_params)

    if @menu.save
      redirect_to root_path, notice: "Cardápio criado com sucesso"
    else
      flash.now[:notice] = "falha ao criar o cardápio"
      render :new , status: :unprocessable_entity
    end
    
  end

  private 

  def menus_params
    menus_params = params
    .require(:menu)
    .permit(
      :name
    )
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def authorize_menu!
    unless @restaurant.user_id == current_user.id
      redirect_to root_path, alert: 'Acesso negado!'
    end
  end

end