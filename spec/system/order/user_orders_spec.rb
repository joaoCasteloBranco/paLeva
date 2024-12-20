require 'rails_helper'

describe 'Usuário inicia um novo pedido' do
  it 'e adiciona dados do cliente' do
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

    menu = Menu.create!(
      name: "Almoço executivo",
      restaurant: restaurant
    )

    # Act 
    login_as(user, :scope => :user)
    visit root_path
    click_on "Criar Novo Pedido"
    fill_in 'Nome do Cliente', with: 'João'
    fill_in 'Telefone', with: "6731423872"
    fill_in 'CPF', with: '109.789.030-99' 
    fill_in 'E-mail', with: 'joao.silva@email.com'
    click_on "Criar Novo Pedido"
    
    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso.'

    click_on "Pedidos"
    expect(page).to have_content 'João'
    expect(page).to have_content "6731423872"
    expect(page).to have_content '109.789.030-99'
    expect(page).to have_content 'joao.silva@email.com'
    
  end

  it 'e vê porções do pedido' do
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
      serving: serving
    )

    menu = Menu.create!(
      name: "Almoço executivo",
      restaurant: restaurant
    )

    # Act 
    login_as(user, :scope => :user)
    visit root_path
    visit restaurant_order_path(restaurant.id, order.id)

    # Assert
    expect(page).to have_content 'Porção Teste (600g)'
    expect(page).to have_content "Valor Total do Pedido: R$ 10,00"
    
  end

  it 'e vê valor total do pedido' do
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
      serving: serving_1
    )


    order_item = OrderItem.create!(
      order: order,
      serving: serving_2
    )

    menu = Menu.create!(
      name: "Almoço executivo",
      restaurant: restaurant
    )

    
    # Act 
    login_as(user, :scope => :user)
    visit root_path
    visit restaurant_order_path(restaurant.id, order.id)

    # Assert
    expect(page).to have_content 'Porção Teste (600g)'
    expect(page).to have_content 'Porção Teste (1200g)'

    expect(page).to have_content "Valor Total do Pedido: R$ 30,00"
    
  end

  it 'e falha por cpf inválido' do
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

    menu = Menu.create!(
      name: "Almoço executivo",
      restaurant: restaurant
    )

    # Act 
    login_as(user, :scope => :user)
    visit root_path
    click_on "Criar Novo Pedido"
    fill_in 'Nome do Cliente', with: 'João'
    fill_in 'Telefone', with: "6731423872"
    fill_in 'CPF', with: '123.456.789-10' 
    fill_in 'E-mail', with: 'joao.silva@email.com'
    click_on "Criar Novo Pedido"
    
    # Assert
    expect(page).to have_content 'Não foi possível registrar o pedido'

    click_on "Pedidos"
    expect(page).not_to have_content 'João'
    expect(page).not_to have_content "6731423872"
    expect(page).not_to have_content '123.456.789-10'
    expect(page).not_to have_content 'joao.silva@email.com'
    
  end

  it 'e com sucesso com apenas email' do
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

    menu = Menu.create!(
      name: "Almoço executivo",
      restaurant: restaurant
    )

    # Act 
    login_as(user, :scope => :user)
    visit root_path
    click_on "Criar Novo Pedido"
    fill_in 'Nome do Cliente', with: 'João'
    fill_in 'CPF', with: '109.789.030-99' 
    fill_in 'E-mail', with: 'joao.silva@email.com'
    click_on "Criar Novo Pedido"
    
    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso.'

    click_on "Pedidos"
    expect(page).to have_content 'João'
    expect(page).to have_content '109.789.030-99'
    expect(page).to have_content 'joao.silva@email.com'
    
  end

  it 'e com sucesso com apenas telefone' do
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

    menu = Menu.create!(
      name: "Almoço executivo",
      restaurant: restaurant
    )

    # Act 
    login_as(user, :scope => :user)
    visit root_path
    click_on "Criar Novo Pedido"
    fill_in 'Nome do Cliente', with: 'João'
    fill_in 'Telefone', with: "6731423872"
    fill_in 'CPF', with: '109.789.030-99' 
    click_on "Criar Novo Pedido"
    
    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso.'

    click_on "Pedidos"
    expect(page).to have_content 'João'
    expect(page).to have_content "6731423872"
    expect(page).to have_content '109.789.030-99'
    
  end
end

describe 'Status do pedido é alterado' do
  it 'e possui histórico de mudanças' do
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

    serving_1 = Serving.create!(
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
      serving: serving_1,
      note: "Sem Cebola"
    )
    
    # Act
    order.update(status: :awaiting_confirmation)
    
    # Assert
    
    expect(order.status_historics).to be_present
    expect(order.status_historics.last.changed_at).to be_present
    expect(order.status_historics.last.status).to eq 'awaiting_confirmation'
  end

  it 'E possui histório para todas as mudanças' do
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
  
      serving_1 = Serving.create!(
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
        serving: serving_1,
        note: "Sem Cebola"
      )
      
      # Act
      order.update(status: :awaiting_confirmation)
      order.update(status: :in_preparation)
      
      # Assert
      
      expect(order.status_historics).to be_present
      expect(order.status_historics.length).to eq 2

      expect(order.status_historics.first.status).to eq 'awaiting_confirmation'
      expect(order.status_historics.last.status).to eq 'in_preparation'
    end

end