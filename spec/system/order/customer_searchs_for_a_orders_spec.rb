require 'rails_helper'

describe 'Cliente pesquisa por um pedido' do
  it 'e com sucesso' do
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
    
    order.update(status: :awaiting_confirmation)

    # Act
    visit root_path
    click_on 'Ver Detalhes do Meu Pedido'
    fill_in 'Código do Pedido', with: order.code
    click_on 'Consultar'

    # Assert
    expect(page).to have_content restaurant.comercial_name
    expect(page).to have_content restaurant.address
    expect(page).to have_content restaurant.email
    expect(page).to have_content restaurant.phone

    expect(page).to have_content 'Esperando confirmação'
    expect(page).to have_content I18n.localize(order.status_historics.last.changed_at, format: :long)


  end

  it 'e vê todas as mudanças de status' do
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
    
    order.update(status: :awaiting_confirmation)
    order.update(status: :in_preparation)

    # Act
    visit root_path
    click_on 'Ver Detalhes do Meu Pedido'
    fill_in 'Código do Pedido', with: order.code
    click_on 'Consultar'

    # Assert
    expect(page).to have_content restaurant.comercial_name
    expect(page).to have_content restaurant.address
    expect(page).to have_content restaurant.email
    expect(page).to have_content restaurant.phone

    expect(page).to have_content 'Esperando confirmação'
    expect(page).to have_content I18n.localize(order.status_historics.first.changed_at, format: :long)

    expect(page).to have_content 'Em Preparação'
    expect(page).to have_content I18n.localize(order.status_historics.last.changed_at, format: :long)


  end

  it 'mas falha com um código inválido' do
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
    
    order.update(status: :awaiting_confirmation)
    order.update(status: :in_preparation)

    # Act
    visit root_path
    click_on 'Ver Detalhes do Meu Pedido'
    fill_in 'Código do Pedido', with: '1NV4L1D0'
    click_on 'Consultar'

    # Assert
    expect(page).not_to have_content restaurant.comercial_name
    expect(page).not_to have_content restaurant.address
    expect(page).not_to have_content restaurant.email
    expect(page).not_to have_content restaurant.phone

    expect(page).not_to have_content 'Esperando confirmação'
    expect(page).not_to have_content I18n.localize(order.status_historics.first.changed_at, format: :long)

    expect(page).not_to have_content 'Em Preparação'
    expect(page).not_to have_content I18n.localize(order.status_historics.last.changed_at, format: :long)

    expect(page).to have_content 'Código inválido. Tente novamente.'
  end


  it 'mas o pedido ainda está sendo cadastrado' do
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
    visit root_path
    click_on 'Ver Detalhes do Meu Pedido'
    fill_in 'Código do Pedido', with: order.code
    click_on 'Consultar'

    # Assert
    expect(page).not_to have_content restaurant.comercial_name
    expect(page).not_to have_content restaurant.address
    expect(page).not_to have_content restaurant.email
    expect(page).not_to have_content restaurant.phone

    expect(page).not_to have_content 'Esperando confirmação'
    expect(page).not_to have_content 'Em Preparação'


    expect(page).to have_content 'Pedido ainda está sendo cadastrado no sistema.'


  end
end