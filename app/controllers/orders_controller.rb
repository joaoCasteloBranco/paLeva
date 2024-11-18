class OrdersController < ApplicationController
  before_action :set_restaurant

  def index
    @orders = @restaurant.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = @restaurant.orders.build(order_params)
    if @order.save
      redirect_to new_restaurant_order_order_item_path(@restaurant, @order), notice: 'Pedido registrado com sucesso.'
    else
      flash.now[:notice] = "Não foi possível registrar o pedido"
      render :new, status: :unprocessable_entity
    end
  end

  def close_order
    @order = Order.find(params[:id])
    @order.awaiting_confirmation!
    redirect_to restaurant_orders_path(@restaurant, @order), notice: "#{@order.code} agora está completo"
  end

  private

  def order_params
    order_params = params
      .require(:order)
      .permit(
        :customer_name,
        :contact_phone,
        :contact_email,
        :cpf
      )
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

end