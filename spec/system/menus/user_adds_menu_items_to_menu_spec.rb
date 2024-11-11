require 'rails_helper'

describe 'Usuário adiciona um item do menu ao menu' do
  it 'e adiciona um item com sucesso' do
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

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on "Adicionar Itens"
    select "Bebida Teste", from: "Itens:"
    click_on "Adicionar Item"

    # Assert
    expect(page).to have_content "Cadastrado com sucesso"

    visit root_path
    click_on "Almoço executivo"

    expect(page).to have_content "Bebida Teste"

  end

  it 'e adiciona a outro cardápio com sucesso' do
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

    menu_1 = Menu.create!(
      name: "Almoço executivo",
      restaurant: restaurant
    )

    menu_2 = Menu.create!(
      name: "Café da Manhã",
      restaurant: restaurant
    )

    beverage = Beverage.create!(
      restaurant: restaurant, 
      name: "Bebida Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300,
      alcoholic: false
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path

    within "#menu_#{menu_1.id}" do
      click_on "Adicionar Itens"
    end
    select "Bebida Teste", from: "Itens:"
    click_on "Adicionar Item"
    visit root_path

    within "#menu_#{menu_2.id}" do
      click_on "Adicionar Itens"
    end
    select "Bebida Teste", from: "Itens:"
    click_on "Adicionar Item"
    visit root_path

    # Assert
    click_on "Almoço executivo"
    expect(page).to have_content "Bebida Teste"
    
    visit root_path

    click_on "Café da Manhã"
    expect(page).to have_content "Bebida Teste"
    

  end

  it 'e adiciona mais de um item com sucesso' do
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

    Beverage.create!(
      restaurant: restaurant, 
      name: "Bebida Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300,
      alcoholic: false
    )

    Dish.create!(
      restaurant: restaurant, 
      name: "Prato Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300,
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on "Adicionar Itens"

    select "Bebida Teste", from: "Itens:"
    click_on "Adicionar Item"

    select "Prato Teste", from: "Itens:"
    click_on "Adicionar Item"
    
    # Assert
    expect(page).to have_content "Cadastrado com sucesso"

    visit root_path
    click_on "Almoço executivo"

    
    expect(page).to have_content "Bebida Teste"
    expect(page).to have_content "Prato Teste"
    
  end

  it 'e adiciona dois itens iguais, com falha' do
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

    MenuContent.create!(
      menu: menu,
      menu_item: beverage
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on "Adicionar Itens"

    select "Bebida Teste", from: "Itens:"
    click_on "Adicionar Item"
    
    # Assert
    expect(page).not_to have_content "Cadastrado com sucesso"
    expect(page).to have_content "Não foi possível realizar o cadastro"

    visit root_path
    click_on "Almoço executivo"

    expect(page).to have_content "Bebida Teste"

  end
end