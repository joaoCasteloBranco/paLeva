class Api::V1::OrdersController < ActionController::API

  def index
    
    restaurant = Restaurant.find_by(code: params[:restaurant_id])

    if restaurant.nil?
      return render status: 404, json: { error: 'Restaurante não encontrado' }
    end    

    valid_statuses = ['awaiting_confirmation', 'in_preparation', 'canceled', 'ready', 'delivered']
    if params[:status].present? && valid_statuses.include?(params[:status])
      status = Order.statuses[params[:status]]

      orders = restaurant.orders
      .where(status: status)
      .includes(order_items: { serving: :menu_item })
    
    else
      orders = restaurant.orders
      .includes(order_items: { serving: :menu_item })
    end
  
    orders_data = orders.map do |order|
      order_items = order.order_items.map do |order_item|
        {
          menu_item: order_item.serving.menu_item.name,  
          note: order_item.note  
        }
      end

      {
        order_code: order.code, 
        customer_name: order.customer_name, 
        order_items: order_items,  
        status: order.status, 
        created_at: order.created_at,
        contact_phone: order.contact_phone,
        contact_email: order.contact_email,
        cpf: order.cpf
      }
    end

    render status: 200, json: {
        orders: orders_data
    }
  end

  def show
    
    restaurant = Restaurant.find_by(code: params[:restaurant_id])

    if restaurant.nil?
      return render status: 404, json: { error: 'Restaurante não encontrado' }
    end

    order = restaurant.orders.find_by(code: params[:id])
    
    if order.nil?
      return render status: 404, json: { error: 'Pedido não encontrado' }
    end

    order_items = order.order_items.includes(serving: :menu_item).map do |order_item|
      {
        menu_item: order_item.serving.menu_item.name,
        note: order_item.note
      }
    end

    render status: 200, json: {
      order: order,
      order_items: order_items
    }
  end

  def in_preparation

    restaurant = Restaurant.find_by(code: params[:restaurant_id])

    if restaurant.nil?
      return render status: 404, json: { error: 'Restaurante não encontrado' }
    end   
    
    order = restaurant.orders.find_by(code: params[:id])
    
    if order.nil?
      return render status: 404, json: { error: 'Pedido não encontrado' }
    end

    unless order.awaiting_confirmation?
      return render status: 422, json: { error: 'Transição de status não permitida' }
    end

    if order.in_preparation!
      render status: 200, json: {
        message: 'Pedido atualizado para "em preparação"',
        order: {
          order: order,
          code: order.code,
          status: order.status,
          updated_at: order.updated_at
        }
      }
    else
      render status: 422, json: { error: 'Falha ao atualizar o status do pedido' }
    end
  end

  def ready

    restaurant = Restaurant.find_by(code: params[:restaurant_id])

    if restaurant.nil?
      return render status: 404, json: { error: 'Restaurante não encontrado' }
    end   
    
    order = restaurant.orders.find_by(code: params[:id])
    
    if order.nil?
      return render status: 404, json: { error: 'Pedido não encontrado' }
    end

    unless order.in_preparation?
      return render status: 422, json: { error: 'Transição de status não permitida' }
    end

    if order.ready!
      render status: 200, json: {
        message: 'Pedido atualizado para "em preparação"',
        order: {
          order: order,
          code: order.code,
          status: order.status,
          updated_at: order.updated_at
        }
      }
    else
      render status: 422, json: { error: 'Falha ao atualizar o status do pedido' }
    end
  end
end