class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @order = Order.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])

    order_params = params
    .require(:order)
    .permit(
      :customer_name,
      :contact_phone,
      :contact_email,
      :cpf
    )

    @order = @restaurant.orders.build(order_params)
    if @order.save
      redirect_to restaurant_order_path(@restaurant, @order), notice: 'Pedido registrado com sucesso.'
    else
      puts @order.errors.full_messages
      flash.now[:notice] = "Não foi possível registrar o pedido"
      render :new, status: :unprocessable_entity
    end
  end

end