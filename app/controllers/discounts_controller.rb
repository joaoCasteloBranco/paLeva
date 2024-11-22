class DiscountsController < ApplicationController

  def show
    @restaurant = Restaurant.find(params[:restaurant_id])
    @discount = @restaurant.discounts.find(params[:id])
  end
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @discount = Discount.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])

    discount_params = params
      .require(:discount)
      .permit(
        :name,
        :value,
        :start_date,
        :end_date,
        :limit_usage
      )


    @discount = @restaurant.discounts.build(discount_params)

    if @discount.save
      redirect_to @restaurant, notice: 'Desconto Criado com sucesso!'
    else
      flash.now[:notice] = "Não foi possível cadastrar o desconto!"
      render :new, status: :unprocessable_entity
    end  

    
  end
end