require 'rails_helper'

describe 'Orders API', type: :request do
  context 'GET /api/v1/restaurant/restaurant_code/orders/order_code' do
    it 'sucess' do
      # Arrange
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )
  
  
      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
        status: :awaiting_confirmation
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      get "/api/v1/restaurants/#{restaurant.code}/orders/#{order.code}"

      json_response = JSON.parse(response.body)

      # Assert
      order = json_response["order"]
      order_items = json_response["order_items"]

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      expect(order['customer_name']).to include 'João'
      expect(order['contact_phone']).to include '6731423872'
      expect(order['contact_email']).to include 'joao.silva@email.com'
      expect(order['cpf']).to include '109.789.030-99'
      expect(order_items.first['menu_item']).to include 'Prato Teste'
      expect(order_items.first['note']).to include 'Sem Cebola'
      expect(order['status']).to include 'awaiting_confirmation'      

    end

    it 'invalid order' do
      # Arrange
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )

      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )

      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )

      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )


      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
      )

      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      get "/api/v1/restaurants/#{restaurant.code}/orders/INVALIDO"

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'Pedido não encontrado'
      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      expect(response.body).not_to include 'Prato Teste'
      expect(response.body).not_to include 'Sem Cebola'
      expect(response.body).not_to include '2024-11-16'
      expect(response.body).not_to include 'awaiting_confirmation'  
    end

    it 'invalid restaurant' do
      # Arrange
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )

      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )

      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )

      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )


      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
      )

      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      get "/api/v1/restaurants/INVALIDO/orders/#{order.code}"

      json_response = JSON.parse(response.body)

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      expect(json_response["error"]).to include 'Restaurante não encontrado'

      expect(response.body).not_to include 'Pedido não encontrado'
      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      expect(response.body).not_to include 'Prato Teste'
      expect(response.body).not_to include 'Sem Cebola'
      expect(response.body).not_to include '2024-11-16'
      expect(response.body).not_to include 'awaiting_confirmation'  
    end

    it 'different restaurant' do
      # Arrange
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )

      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )

      user_2 = User.create!(
        cpf: "662.142.320-99",
        email:  "email@email.com",
        name: "Usuário",
        last_name: "Teste",
        password: "nacoesunidas",
      )

      not_used_restaurant = Restaurant.create!(
        user: user_2,
        registered_name: "Reteteu",
        comercial_name: "Reteteu Restaurante",
        cnpj: "50.934.557/0001-78",
        address: "Av. 1000",
        phone: "6731423872",
        email: "reteteu@restaurante.com"
      )

      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )

      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )


      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
      )

      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      get "/api/v1/restaurants/#{not_used_restaurant.code}/orders/#{order.code}"

      json_response = JSON.parse(response.body)

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'Pedido não encontrado'

      expect(json_response['error']).not_to include 'Restaurante não encontrado'
      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      expect(response.body).not_to include 'Prato Teste'
      expect(response.body).not_to include 'Sem Cebola'
      expect(response.body).not_to include '2024-11-16'
      expect(response.body).not_to include 'awaiting_confirmation'  
    end
  end

  context 'GET /api/v1/restaurant/restaurant_code/orders/' do
    it 'sucess' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving_1 = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )

      serving_2 = Serving.create!(
        menu_item: dish,
        price: 2000,
        description: 'Porção Teste (1200g)'
      )
  
  
      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
        status: :awaiting_confirmation
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving_1,
        note: "Sem Cebola"
      )

      order_item_2 = OrderItem.create!(
        order: order,
        serving: serving_2,
        note: "Com Cebola"
      )

      # Act
      get "/api/v1/restaurants/#{restaurant.code}/orders/"

      json_response = JSON.parse(response.body)
      orders_response = json_response['orders']
      order_1_response = orders_response.first['order']
      order_items_response_1 = orders_response.first['order_items'].first     
      order_items_response_2 = orders_response.first['order_items'].last

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(order_1_response['customer_name']).to include 'João'
      expect(order_1_response['contact_phone']).to include '6731423872'
      expect(order_1_response['contact_email']).to include 'joao.silva@email.com'
      expect(order_1_response['cpf']).to include '109.789.030-99'
      expect(order_1_response['status']).to include 'awaiting_confirmation' 
      
      expect(order_items_response_1['menu_item']).to include 'Prato Teste'
      expect(order_items_response_1['note']).to include 'Sem Cebola'
         
      expect(order_items_response_2['menu_item']).to include 'Prato Teste'
      expect(order_items_response_2['note']).to include 'Com Cebola'
     

    end

    it 'sucess, filter status' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving_1 = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )

      serving_2 = Serving.create!(
        menu_item: dish,
        price: 2000,
        description: 'Porção Teste (1200g)'
      )
  
      beverage = Beverage.create!(
        restaurant: restaurant, 
        name: "Bebida Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300,
        alcoholic: false
      )
  
      serving_3 = Serving.create!(
        menu_item: beverage,
        price: 1000,
        description: 'Embalagem Teste (150ml)'
      )

      serving_4 = Serving.create!(
        menu_item: beverage,
        price: 2000,
        description: 'Embalagem Teste (300ml)'
      )
  
  
      order_1 = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
        status: :awaiting_confirmation
      )
  
      order_item = OrderItem.create!(
        order: order_1,
        serving: serving_1,
        note: "Sem Cebola"
      )

      order_item_2 = OrderItem.create!(
        order: order_1,
        serving: serving_2,
        note: "Com Cebola"
      )

      order_2 = Order.create!(
        restaurant: restaurant,
        customer_name: 'Carlos',
        contact_phone: "6731423873",
        contact_email: 'carlos.silva@email.com',
        cpf: '662.142.320-99',
        status: :editing
      )
  
      order_item_3 = OrderItem.create!(
        order: order_2,
        serving: serving_3,
        note: "Fria"
      )

      order_item_4 = OrderItem.create!(
        order: order_2,
        serving: serving_4,
        note: "Quente"
      )

      # Act
      get "/api/v1/restaurants/#{restaurant.code}/orders/?status=editing"

      json_response = JSON.parse(response.body)
      orders_response = json_response['orders']
      
      order_2_response = orders_response.last['order']
      order_items_response_3 = orders_response.last['order_items'].first     
      order_items_response_4 = orders_response.last['order_items'].last

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      
      expect(response.body).not_to include 'Prato Teste'
      expect(response.body).not_to include 'Sem Cebola'   
      expect(response.body).not_to include 'Com Cebola'

      expect(order_2_response['customer_name']).to include 'Carlos'
      expect(order_2_response['contact_phone']).to include '6731423873'
      expect(order_2_response['contact_email']).to include 'carlos.silva@email.com'
      expect(order_2_response['cpf']).to include '662.142.320-99'

      expect(order_items_response_3['menu_item']).to include 'Bebida Teste'
      expect(order_items_response_3['note']).to include  'Fria'
      expect(order_items_response_4['note']).to include 'Quente'   

    end

    it 'sucess, invalid status' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving_1 = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )

      serving_2 = Serving.create!(
        menu_item: dish,
        price: 2000,
        description: 'Porção Teste (1200g)'
      )
  
      beverage = Beverage.create!(
        restaurant: restaurant, 
        name: "Bebida Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300,
        alcoholic: false
      )
  
      serving_3 = Serving.create!(
        menu_item: beverage,
        price: 1000,
        description: 'Embalagem Teste (150ml)'
      )

      serving_4 = Serving.create!(
        menu_item: beverage,
        price: 2000,
        description: 'Embalagem Teste (300ml)'
      )
  
  
      order_1 = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
        status: :awaiting_confirmation
      )
  
      order_item = OrderItem.create!(
        order: order_1,
        serving: serving_1,
        note: "Sem Cebola"
      )

      order_item_2 = OrderItem.create!(
        order: order_1,
        serving: serving_2,
        note: "Com Cebola"
      )

      order_2 = Order.create!(
        restaurant: restaurant,
        customer_name: 'Carlos',
        contact_phone: "6731423873",
        contact_email: 'carlos.silva@email.com',
        cpf: '662.142.320-99',
        status: :editing
      )
  
      order_item_3 = OrderItem.create!(
        order: order_2,
        serving: serving_3,
        note: "Fria"
      )

      order_item_4 = OrderItem.create!(
        order: order_2,
        serving: serving_4,
        note: "Quente"
      )

      # Act
      get "/api/v1/restaurants/#{restaurant.code}/orders/?status=invalido"
      json_response = JSON.parse(response.body)
      orders_response = json_response['orders']
      order_1_response = orders_response.first['order']
      order_items_response_1 = orders_response.first['order_items'].first     
      order_items_response_2 = orders_response.first['order_items'].last

      order_2_response = orders_response.last['order']
      order_items_response_3 = orders_response.last['order_items'].first     
      order_items_response_4 = orders_response.last['order_items'].last

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      expect(order_1_response['customer_name']).to include 'João'
      expect(order_1_response['contact_phone']).to include '6731423872'
      expect(order_1_response['contact_email']).to include 'joao.silva@email.com'
      expect(order_1_response['cpf']).to include '109.789.030-99'
      
      expect(order_items_response_1['menu_item']).to include 'Prato Teste'
      expect(order_items_response_1['note']).to include 'Sem Cebola'   
      expect(order_items_response_2['note']).to include 'Com Cebola'

      expect(order_2_response['customer_name']).to include 'Carlos'
      expect(order_2_response['contact_phone']).to include '6731423873'
      expect(order_2_response['contact_email']).to include 'carlos.silva@email.com'
      expect(order_2_response['cpf']).to include '662.142.320-99'

      expect(order_items_response_3['menu_item']).to include 'Bebida Teste'
      expect(order_items_response_3['note']).to include  'Fria'
      expect(order_items_response_4['note']).to include 'Quente'  

    end

    it 'sucess, empty status' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving_1 = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )

      serving_2 = Serving.create!(
        menu_item: dish,
        price: 2000,
        description: 'Porção Teste (1200g)'
      )
  
      beverage = Beverage.create!(
        restaurant: restaurant, 
        name: "Bebida Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300,
        alcoholic: false
      )
  
      serving_3 = Serving.create!(
        menu_item: beverage,
        price: 1000,
        description: 'Embalagem Teste (150ml)'
      )

      serving_4 = Serving.create!(
        menu_item: beverage,
        price: 2000,
        description: 'Embalagem Teste (300ml)'
      )
  
  
      order_1 = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
        status: :awaiting_confirmation
      )
  
      order_item = OrderItem.create!(
        order: order_1,
        serving: serving_1,
        note: "Sem Cebola"
      )

      order_item_2 = OrderItem.create!(
        order: order_1,
        serving: serving_2,
        note: "Com Cebola"
      )

      order_2 = Order.create!(
        restaurant: restaurant,
        customer_name: 'Carlos',
        contact_phone: "6731423873",
        contact_email: 'carlos.silva@email.com',
        cpf: '662.142.320-99',
        status: :editing
      )
  
      order_item_3 = OrderItem.create!(
        order: order_2,
        serving: serving_3,
        note: "Fria"
      )

      order_item_4 = OrderItem.create!(
        order: order_2,
        serving: serving_4,
        note: "Quente"
      )

      # Act
      get "/api/v1/restaurants/#{restaurant.code}/orders/?status="
      json_response = JSON.parse(response.body)
      orders_response = json_response['orders']
      order_1_response = orders_response.first['order']
      order_items_response_1 = orders_response.first['order_items'].first     
      order_items_response_2 = orders_response.first['order_items'].last

      order_2_response = orders_response.last['order']
      order_items_response_3 = orders_response.last['order_items'].first     
      order_items_response_4 = orders_response.last['order_items'].last

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      expect(order_1_response['customer_name']).to include 'João'
      expect(order_1_response['contact_phone']).to include '6731423872'
      expect(order_1_response['contact_email']).to include 'joao.silva@email.com'
      expect(order_1_response['cpf']).to include '109.789.030-99'
      
      expect(order_items_response_1['menu_item']).to include 'Prato Teste'
      expect(order_items_response_1['note']).to include 'Sem Cebola'   
      expect(order_items_response_2['note']).to include 'Com Cebola'

      expect(order_2_response['customer_name']).to include 'Carlos'
      expect(order_2_response['contact_phone']).to include '6731423873'
      expect(order_2_response['contact_email']).to include 'carlos.silva@email.com'
      expect(order_2_response['cpf']).to include '662.142.320-99'

      expect(order_items_response_3['menu_item']).to include 'Bebida Teste'
      expect(order_items_response_3['note']).to include  'Fria'
      expect(order_items_response_4['note']).to include 'Quente'  

    end

    it 'fails, diferrent restaurant' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )

      user_2 = User.create!(
        cpf: "662.142.320-99",
        email:  "email@email.com",
        name: "Usuário",
        last_name: "Teste",
        password: "nacoesunidas",
      )

      not_used_restaurant = Restaurant.create!(
        user: user_2,
        registered_name: "Reteteu",
        comercial_name: "Reteteu Restaurante",
        cnpj: "50.934.557/0001-78",
        address: "Av. 1000",
        phone: "6731423872",
        email: "reteteu@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving_1 = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )

      serving_2 = Serving.create!(
        menu_item: dish,
        price: 2000,
        description: 'Porção Teste (1200g)'
      )
   
      order_1 = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
        status: :awaiting_confirmation
      )
  
      order_item = OrderItem.create!(
        order: order_1,
        serving: serving_1,
        note: "Sem Cebola"
      )

      order_item_2 = OrderItem.create!(
        order: order_1,
        serving: serving_2,
        note: "Com Cebola"
      )

      # Act
      get "/api/v1/restaurants/#{not_used_restaurant.code}/orders/?status=invalido"


      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      
      expect(response.body).not_to include 'Prato Teste'
      expect(response.body).not_to include 'Sem Cebola'   
      expect(response.body).not_to include 'Com Cebola'
    end

    it 'fails, invalid restaurant' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving_1 = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )

      serving_2 = Serving.create!(
        menu_item: dish,
        price: 2000,
        description: 'Porção Teste (1200g)'
      )
   
      order_1 = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
        status: :awaiting_confirmation
      )
  
      order_item = OrderItem.create!(
        order: order_1,
        serving: serving_1,
        note: "Sem Cebola"
      )

      order_item_2 = OrderItem.create!(
        order: order_1,
        serving: serving_2,
        note: "Com Cebola"
      )

      # Act
      get "/api/v1/restaurants/INVALID/orders/?status=invalido"


      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'

      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      
      expect(response.body).not_to include 'Prato Teste'
      expect(response.body).not_to include 'Sem Cebola'   
      expect(response.body).not_to include 'Com Cebola'
    end
  end

  context 'POST /api/v1/restaurant/restaunrant_code/orders/order_code/in_preparation' do 
    it 'sucess change' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )
  
  
      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
        status: :awaiting_confirmation
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      post "/api/v1/restaurants/#{restaurant.code}/orders/#{order.code}/in_preparation"
      json_response = JSON.parse(response.body)

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(json_response['message']).to include 'Pedido atualizado'
      expect(json_response['order']['order']['customer_name']).to include 'João'
      expect(json_response['order']['order']['contact_phone']).to include '6731423872'
      expect(json_response['order']['order']['contact_email']).to include 'joao.silva@email.com'
      expect(json_response['order']['order']['cpf']).to include '109.789.030-99'
      expect(json_response['order']['order']['status']).to include 'in_preparation'      

    end

    it 'fail, invalid order' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )
  
  
      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      post "/api/v1/restaurants/#{restaurant.code}/orders/INVALID/in_preparation"

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      expect(response.body).not_to include 'in_preparation'      

    end

    it 'fail, invalid order' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )

      user_2 = User.create!(
        cpf: "662.142.320-99",
        email:  "email@email.com",
        name: "Usuário",
        last_name: "Teste",
        password: "nacoesunidas",
      )

      not_used_restaurant = Restaurant.create!(
        user: user_2,
        registered_name: "Reteteu",
        comercial_name: "Reteteu Restaurante",
        cnpj: "50.934.557/0001-78",
        address: "Av. 1000",
        phone: "6731423872",
        email: "reteteu@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )
  
  
      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      post "/api/v1/restaurants/#{not_used_restaurant.code}/orders/INVALID/in_preparation"

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      expect(response.body).not_to include 'in_preparation'      

    end

    it 'fail, alrady in preparation' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )
  
  
      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
        status: :in_preparation
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      post "/api/v1/restaurants/#{restaurant.code}/orders/#{order.code}/in_preparation"

      # Assert
      expect(response.status).to eq 422
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'Transição de status não permitida'
      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      expect(response.body).not_to include 'in_preparation'      

    end

    it 'fail, invalid restaurant' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )
  
  
      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      post "/api/v1/restaurants/INVALID/orders/#{order.code}/in_preparation"

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      expect(response.body).not_to include 'in_preparation'      

    end
  end

  context 'POST /api/v1/restaurant/restaunrant_code/orders/order_code/ready' do 
    it 'sucess change' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )
  
  
      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
        status: :in_preparation
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      post "/api/v1/restaurants/#{restaurant.code}/orders/#{order.code}/ready"

      json_response = JSON.parse(response.body)

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(json_response['message']).to include 'Pedido atualizado'
      expect(json_response['order']['order']['customer_name']).to include 'João'
      expect(json_response['order']['order']['contact_phone']).to include '6731423872'
      expect(json_response['order']['order']['contact_email']).to include 'joao.silva@email.com'
      expect(json_response['order']['order']['cpf']).to include '109.789.030-99'
      expect(json_response['order']['order']['status']).to include 'ready'  

    end

    it 'fail, invalid order' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )
  
  
      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      post "/api/v1/restaurants/#{restaurant.code}/orders/INVALID/ready"

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      expect(response.body).not_to include 'ready'      

    end

    it 'fail, invalid order' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )

      user_2 = User.create!(
        cpf: "662.142.320-99",
        email:  "email@email.com",
        name: "Usuário",
        last_name: "Teste",
        password: "nacoesunidas",
      )

      not_used_restaurant = Restaurant.create!(
        user: user_2,
        registered_name: "Reteteu",
        comercial_name: "Reteteu Restaurante",
        cnpj: "50.934.557/0001-78",
        address: "Av. 1000",
        phone: "6731423872",
        email: "reteteu@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )
  
  
      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      post "/api/v1/restaurants/#{not_used_restaurant.code}/orders/INVALID/ready"

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      expect(response.body).not_to include 'ready'      

    end

    it 'fail, alrady ready' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )
  
  
      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
        status: :ready
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      post "/api/v1/restaurants/#{restaurant.code}/orders/#{order.code}/ready"

      # Assert
      expect(response.status).to eq 422
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'Transição de status não permitida'
      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      expect(response.body).not_to include 'ready'      

    end

    it 'fail, invalid restaurant' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )
  
  
      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      post "/api/v1/restaurants/INVALID/orders/#{order.code}/ready"

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      expect(response.body).not_to include 'ready'      

    end
  end

  context 'POST /api/v1/restaurant/restaunrant_code/orders/order_code/canceled' do 
    it 'sucess change' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )
  
  
      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
        status: :in_preparation
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Com Cebola"
      )

      # Act 
      
      post "/api/v1/restaurants/#{restaurant.code}/orders/#{order.code}/canceled"

      json_response = JSON.parse(response.body)

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(json_response['message']).to include 'Pedido atualizado'
      expect(json_response['order']['order']['customer_name']).to include 'João'
      expect(json_response['order']['order']['contact_phone']).to include '6731423872'
      expect(json_response['order']['order']['contact_email']).to include 'joao.silva@email.com'
      expect(json_response['order']['order']['cpf']).to include '109.789.030-99'
      expect(json_response['order']['order']['status']).to include 'canceled'  
    end
  end

  it 'fail, invalid order' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )
  
  
      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      post "/api/v1/restaurants/#{restaurant.code}/orders/INVALID/canceled"
    
      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      expect(response.body).not_to include 'canceled'      

    end

    it 'fail, alrady canceled' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
      )
  
      restaurant = Restaurant.create!(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
  
      dish = Dish.create!(
        restaurant: restaurant, 
        name: "Prato Teste",
        description: 'Uma descrição do prato de teste.',
        calories: 300
      )
  
      serving = Serving.create!(
        menu_item: dish,
        price: 1000,
        description: 'Porção Teste (600g)'
      )
  
  
      order = Order.create!(
        restaurant: restaurant,
        customer_name: 'João',
        contact_phone: "6731423872",
        contact_email: 'joao.silva@email.com',
        cpf: '109.789.030-99',
        status: :canceled
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      post "/api/v1/restaurants/#{restaurant.code}/orders/#{order.code}/canceled"

      # Assert
      expect(response.status).to eq 422
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'Falha ao atualizar o status do pedido'
      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      expect(response.body).not_to include 'ready'      

    end
end