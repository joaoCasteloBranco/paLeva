class Api::V1::OrdersController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    restaurant = find_restaurant

    valid_statuses = Order.statuses.keys

    if params[:status].present? && valid_statuses.include?(params[:status])
      status = Order.statuses[params[:status]]

      orders = restaurant.orders
      .where(status: status)
      .includes(order_items: { serving: :menu_item })
    
    else
      orders = restaurant.orders
      .includes(order_items: { serving: :menu_item })
    end
  

    render status: 200, json: {
        orders: format_orders(orders)
    }
  end

  def show

    restaurant = find_restaurant

    order = find_order(restaurant)

    render status: 200, json: {
      order: format_order(order),
      order_items: format_order_items(order.order_items)
    }
  end

  def in_preparation

    restaurant = find_restaurant
    order = find_order(restaurant)

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

    restaurant = find_restaurant
    order = find_order(restaurant)

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

  private

  def find_restaurant
    Restaurant.find_by!(code: params[:restaurant_id])
  end

  def find_order(restaurant)
    restaurant.orders.find_by!(code: params[:id])
  end

  def record_not_found(exception)
    resource_name = exception.model&.underscore || "default"
    error_message = I18n.t("errors.not_found.#{resource_name}", default: I18n.t("errors.not_found.default"))
  
    render status: 404, json: { error: error_message }
  end

  def format_order(order)
    {
      order_code: order.code,
      customer_name: order.customer_name,
      status: order.status,
      created_at: order.created_at,
      contact_phone: order.contact_phone,
      contact_email: order.contact_email,
      cpf: order.cpf
    }
  end

  def format_orders(orders)
    orders.map { |order| {
        order: format_order(order),
        order_items: format_order_items(order.order_items)
      } 
    }
  end

  def format_order_items(order_items)
    order_items.map do |item|
      {
        menu_item: item.serving.menu_item.name,
        note: item.note
      }
    end
  end

  def update_order_status(order, new_status, required_status)
    unless order.status.to_s == required_status.to_s
      return render status: 422, json: { error: 'Transição de status não permitida' }
    end

    if order.update(status: new_status)
      render status: 200, json: {
        message: "Pedido atualizado",
        order: format_order(order)
      }
    else
      render status: 422, json: { error: 'Falha ao atualizar o status do pedido' }
    end
  end


end