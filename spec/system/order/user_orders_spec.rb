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

    # Act 
    login_as(user)
    visit root_path
    click_on "Criar Novo Pedido"
    fill_in 'Nome do Cliente', with: 'João'
    fill_in 'Telefone', with: "6731423872"
    fill_in 'CPF', with: '109.789.030-99' 
    fill_in 'E-mail', with: 'joao.silva@email.com'
    click_on "Criar Novo Pedido"

    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso.'
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

    
    # Act 
    login_as(user)
    visit root_path
    visit restaurant_order_path(restaurant.id, order.id)

    # Assert
    expect(page).to have_content 'Porção Teste (600g)'
    expect(page).to have_content "Preço: R$ 10,00"
    
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

    
    # Act 
    login_as(user)
    visit root_path
    visit restaurant_order_path(restaurant.id, order.id)

    # Assert
    expect(page).to have_content 'Porção Teste (600g)'
    expect(page).to have_content "Preço: R$ 10,00"

    expect(page).to have_content 'Porção Teste (1200g)'
    expect(page).to have_content "Preço: R$ 20,00"

    expect(page).to have_content "Valor Total do Pedido: R$ 30,00"
    
  end
end