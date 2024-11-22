class DiscountServingsController < ApplicationController

  def new 
    @restaurant = Restaurant.find(params[:restaurant_id])
    @discount = Discount.find(params[:discount_id])
    @discount_serving = DiscountServing.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @discount = Discount.find(params[:discount_id])


    discount_serving_params = params.
    require(:discount_serving)
    .permit(
      :serving_id,
    )

    @discount_serving = @discount.discount_servings.build(discount_serving_params)

    if @discount_serving.save
      redirect_to new_restaurant_discount_discount_serving_path(
        @restaurant, @discount
      ), notice: "Cadastrado com sucesso"
    else
      puts @discount_serving.errors.full_messages
      flash.now[:alert] = "Não foi possível realizar o cadastro"
      render :new, status: :unprocessable_entity
    end

  end
end