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
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      get "/api/v1/restaurants/#{restaurant.code}/orders/#{order.code}"

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'João'
      expect(response.body).to include '6731423872'
      expect(response.body).to include 'joao.silva@email.com'
      expect(response.body).to include '109.789.030-99'
      expect(response.body).to include 'Prato Teste'
      expect(response.body).to include 'Sem Cebola'
      expect(response.body).to include 'awaiting_confirmation'      

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

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'Restaurante não encontrado'

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

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'Pedido não encontrado'

      expect(response.body).not_to include 'Restaurante não encontrado'
      expect(response.body).not_to include 'João'
      expect(response.body).not_to include '6731423872'
      expect(response.body).not_to include 'joao.silva@email.com'
      expect(response.body).not_to include '109.789.030-99'
      expect(response.body).not_to include 'Prato Teste'
      expect(response.body).not_to include 'Sem Cebola'
      expect(response.body).not_to include '2024-11-16'
      expect(response.body).not_to include 'awaiting_confirmation'  
    end

    it 'bad request' do
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


      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'João'
      expect(response.body).to include '6731423872'
      expect(response.body).to include 'joao.silva@email.com'
      expect(response.body).to include '109.789.030-99'
      expect(response.body).to include 'Prato Teste'
      expect(response.body).to include 'Sem Cebola'
      expect(response.body).to include 'awaiting_confirmation'     
      expect(response.body).to include 'Com Cebola'
      expect(response.body).to include 'awaiting_confirmation'   

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
        status: :canceled
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
      get "/api/v1/restaurants/#{restaurant.code}/orders/?status=canceled"


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

      expect(response.body).to include 'Carlos'
      expect(response.body).to include '6731423873'
      expect(response.body).to include 'carlos.silva@email.com'
      expect(response.body).to include '662.142.320-99'

      expect(response.body).to include 'Bebida Teste'
      expect(response.body).to include 'Quente'   
      expect(response.body).to include 'Fria'

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
        status: :canceled
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


      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      expect(response.body).to include 'João'
      expect(response.body).to include '6731423872'
      expect(response.body).to include 'joao.silva@email.com'
      expect(response.body).to include '109.789.030-99'
      
      expect(response.body).to include 'Prato Teste'
      expect(response.body).to include 'Sem Cebola'   
      expect(response.body).to include 'Com Cebola'

      expect(response.body).to include 'Carlos'
      expect(response.body).to include '6731423873'
      expect(response.body).to include 'carlos.silva@email.com'
      expect(response.body).to include '662.142.320-99'

      expect(response.body).to include 'Bebida Teste'
      expect(response.body).to include 'Quente'   
      expect(response.body).to include 'Fria'

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
        status: :canceled
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


      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      expect(response.body).to include 'João'
      expect(response.body).to include '6731423872'
      expect(response.body).to include 'joao.silva@email.com'
      expect(response.body).to include '109.789.030-99'
      
      expect(response.body).to include 'Prato Teste'
      expect(response.body).to include 'Sem Cebola'   
      expect(response.body).to include 'Com Cebola'

      expect(response.body).to include 'Carlos'
      expect(response.body).to include '6731423873'
      expect(response.body).to include 'carlos.silva@email.com'
      expect(response.body).to include '662.142.320-99'

      expect(response.body).to include 'Bebida Teste'
      expect(response.body).to include 'Quente'   
      expect(response.body).to include 'Fria'

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
      )
  
      order_item = OrderItem.create!(
        order: order,
        serving: serving,
        note: "Sem Cebola"
      )

      # Act 
      post "/api/v1/restaurants/#{restaurant.code}/orders/#{order.code}/in_preparation"

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'João'
      expect(response.body).to include '6731423872'
      expect(response.body).to include 'joao.silva@email.com'
      expect(response.body).to include '109.789.030-99'
      expect(response.body).to include 'in_preparation'      

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

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'João'
      expect(response.body).to include '6731423872'
      expect(response.body).to include 'joao.silva@email.com'
      expect(response.body).to include '109.789.030-99'
      expect(response.body).to include 'ready'      

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
end