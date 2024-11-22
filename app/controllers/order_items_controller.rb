class OrderItemsController < ApplicationController
  before_action :set_restaurant

  def new
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.new
  end

  def create
    @order = Order.find(params[:order_id])

    @order_item = @order.order_items.build(order_item_params)

    if @order_item.save
      redirect_to new_restaurant_order_order_item_path(
        @restaurant, @order
      ), notice: "Cadastrado com sucesso"
    else
      puts @order_item.errors.full_messages
      flash.now[:alert] = "Não foi possível realizar o cadastro"
      render :new, status: :unprocessable_entity
    end

  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def order_item_params
    params.
    require(:order_item)
    .permit(
      :serving_id,
      :note
    )
  end
end