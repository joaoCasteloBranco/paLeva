class OrdersController < ApplicationController
  before_action :set_restaurant, except: [:status, :check]

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

  def status
    
  end

  def result
    @order = Order.find(params[:id])
  end

  def check
    @order = Order.find_by(code: params[:code].upcase)

    if @order
      @restaurant = @order.restaurant
      redirect_to result_restaurant_order_path(@restaurant, @order)
    else
      flash.now[:notice] = 'Código inválido. Tente novamente.'
      render :status, status: :unprocessable_entity
    end
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