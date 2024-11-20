require 'rails_helper'

describe 'Usuário adiciona porção para o pedido' do 
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

    serving = Serving.create!(
      menu_item: dish,
      price: 1000,
      description: 'Porção Teste (600g)'
    )

    menu = Menu.create!(
      name: "Almoço executivo",
      restaurant: restaurant
    )


    MenuContent.create!(
      menu: menu,
      menu_item: dish
    )


    order = Order.create!(
      restaurant: restaurant,
      customer_name: 'João',
      contact_phone: "6731423872",
      contact_email: 'joao.silva@email.com',
      cpf: '109.789.030-99',
    )

    # Act 
    login_as(user, :scope => :user)
    visit root_path
    click_on "Pedidos"
    click_on "joao.silva@email.com"
    click_on "Adicionar Porções ao Pedido"

    fill_in 'Adicionar Nota', with: 'Sem Cebola'

    choose 'Porção Teste (600g)'
    click_on "Adicionar ao Pedido"
    click_on "Fechar Pedido"
    click_on "joao.silva@email.com"

    # Assert
    expect(page).to have_content 'Porção Teste (600g)'
    expect(page).to have_content "Preço: R$ 10,00"

  end

  it 'e adicionar várias porções com sucesso' do
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

    menu = Menu.create!(
      name: "Almoço executivo",
      restaurant: restaurant
    )


    MenuContent.create!(
      menu: menu,
      menu_item: dish
    )


    order = Order.create!(
      restaurant: restaurant,
      customer_name: 'João',
      contact_phone: "6731423872",
      contact_email: 'joao.silva@email.com',
      cpf: '109.789.030-99',
    )

    # Act 
    login_as(user, :scope => :user)
    visit root_path
    click_on "Pedidos"
    click_on "joao.silva@email.com"
    click_on "Adicionar Porções ao Pedido"

    fill_in 'Adicionar Nota', with: 'Sem Cebola'

    choose 'Porção Teste (600g)'
    click_on "Adicionar ao Pedido"

    fill_in 'Adicionar Nota', with: 'Com Cebola'

    choose 'Porção Teste (1200g)'
    click_on "Adicionar ao Pedido"

    click_on "Fechar Pedido"
    click_on "joao.silva@email.com"

    # Assert
    expect(page).to have_content 'Porção Teste (600g)'
    expect(page).to have_content "Preço: R$ 10,00"

    expect(page).to have_content 'Porção Teste (1200g)'
    expect(page).to have_content "Preço: R$ 20,00"

  end

  it 'e adicionar várias porções logo após a criação do pedido com sucesso' do
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

    menu = Menu.create!(
      name: "Almoço executivo",
      restaurant: restaurant
    )


    MenuContent.create!(
      menu: menu,
      menu_item: dish
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
    fill_in 'Adicionar Nota', with: 'Sem Cebola'

    choose 'Porção Teste (600g)'
    click_on "Adicionar ao Pedido"

    fill_in 'Adicionar Nota', with: 'Com Cebola'

    choose 'Porção Teste (1200g)'
    click_on "Adicionar ao Pedido"

    click_on "Fechar Pedido"
    click_on "joao.silva@email.com"

    # Assert
    expect(page).to have_content 'Porção Teste (600g)'
    expect(page).to have_content "Preço: R$ 10,00"

    expect(page).to have_content 'Porção Teste (1200g)'
    expect(page).to have_content "Preço: R$ 20,00"

  end
end