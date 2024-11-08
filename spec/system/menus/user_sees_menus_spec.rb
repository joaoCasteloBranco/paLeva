require 'rails_helper'

describe 'Usuário vizualiza cardápios' do
  it 'e visualiza todos os cardápios' do
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
    
    click_on 'Adicionar Cardápio'
    fill_in "Nome", with: "Almoço Executivo"
    click_on "Adicionar"

    click_on 'Adicionar Cardápio'
    fill_in "Nome", with: "Café da Manhã"
    click_on "Adicionar"

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content "Almoço Executivo"
    expect(page).to have_content "Café da Manhã"
  end

  it 'e visualiza detalhes do cardápio' do
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

    beverage = Beverage.create!(
      restaurant: restaurant, 
      name: "Bebida Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300,
      alcoholic: false
    )

    dish = Dish.create!(
      restaurant: restaurant, 
      name: "Prato Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300,
    )  

    MenuContent.create!(
      menu: menu,
      menu_item: beverage
    )

    MenuContent.create!(
      menu: menu,
      menu_item: dish
    )

    # Act
    login_as(user)
    visit root_path
    click_on "Almoço executivo"

    # Assert
    expect(page).to have_content "Bebida Teste"
    expect(page).to have_content "Prato Teste"
  end

  it 'e visualiza porções dos itens do cardápio' do
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

    beverage = Beverage.create!(
      restaurant: restaurant, 
      name: "Bebida Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300,
      alcoholic: false
    )

    serving_beverage = Serving.create!(
      menu_item: beverage,
      price: 1000,
      description: 'Porção Teste Bebida'
    )

    dish = Dish.create!(
      restaurant: restaurant, 
      name: "Prato Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300,
    )  

    serving_dish = Serving.create!(
      menu_item: dish,
      price: 2000,
      description: 'Porção Teste Prato'
    )

    MenuContent.create!(
      menu: menu,
      menu_item: beverage
    )

    MenuContent.create!(
      menu: menu,
      menu_item: dish
    )

    # Act
    login_as(user)
    visit root_path
    click_on "Almoço executivo"

    # Assert
    expect(page).to have_content "Bebida Teste"
    expect(page).to have_content "Prato Teste"

    expect(page).to have_content 'Porção Teste Bebida'
    expect(page).to have_content 'Preço: R$ 10,00'
    expect(page).to have_content 'Porção Teste Prato'
    expect(page).to have_content 'Preço: R$ 20,00'

  end

  it 'e há pratos inativos para o cardápio' do
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

    beverage = Beverage.create!(
      restaurant: restaurant, 
      name: "Bebida Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300,
      alcoholic: false,
      status: 0
    ) 

    MenuContent.create!(
      menu: menu,
      menu_item: beverage
    )

    # Act
    login_as(user)
    visit root_path
    click_on "Almoço executivo"

    # Assert
    expect(page).not_to have_content "Bebida Teste"
    expect(page).to have_content "Há pratos inativos para esse Cardápio"
    expect(page).to have_content "Esse cardapio não possui pratos ativos"

  end

end