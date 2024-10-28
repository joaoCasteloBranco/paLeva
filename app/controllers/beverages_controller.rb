class BeveragesController < ApplicationController
    before_action :set_restaurant
    before_action :authorize_beverage!, only: [:show]
  
    def index
      @beverage = @restaurant.beverages
    end
  
    def show
      @beverage = @restaurant.beverages.find(params[:id])
    end
  
    def new
      @beverage = @restaurant.beverages.build
    end
  
    def create
      @beverage = @restaurant.beverages.build(beverage_params)
      if @beverage.save
        redirect_to @restaurant, notice: 'Bebida Criada com sucesso!'
      else
        flash.now[:notice] = "Não foi possível cadastrar a bebida!"
        render :new
      end
    end

    def edit
      @beverage = @restaurant.beverages.find(params[:id])
    end
  
    def update
      if @beverage.update(beverage_params)
        redirect_to restaurant_beverage_path(@restaurant, @beverage), notice: 'Bebida atualizada com sucesso!'
      else
        render :edit
      end
    end
  
    def destroy
      @beverage = @restaurant.beverages.find(params[:id])
      @beverage.destroy
      redirect_to restaurant_path(@restaurant), notice: 'Bebida excluída com sucesso!'
    end
  
    private
    
  
    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
  
    def beverage_params
      params
      .require(:beverage)
      .permit(
        :name,
        :description,
        :calories,
        :alcoholic,
        :photo
      )
    end
  
    def authorize_beverage!
      unless @restaurant.user_id == current_user.id
        redirect_to root_path, alert: 'Acesso negado!'
      end
    end
  end
    