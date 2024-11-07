# spec/system/search_spec.rb
require 'rails_helper'

RSpec.describe 'Busca de pratos e bebidas', type: :system do

  it 'e não está autenticado' do
    # Arrange

    # Act
    visit root_path
    # Assert
    expect(page).not_to have_content("Buscar")
  end

  it 'e encontra resultados' do
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

    restaurant.dishes.create!(
      name: "Macarrão Alho e Óleo",
      description: "Prato de macarrão com alho, óleo e temperos"
    )
    restaurant.dishes.create!(
      name: "Salada Caesar",
      description: "Salada com alface, parmesão e croutons"
    )
    Beverage.create!(
    name: "Cerveja",
    description: "Bebida refrescante",
    alcoholic: true,
    restaurant: restaurant
    )

    Beverage.create!(
    name: "Vodka",
    description: "Bebida refrescante",
    alcoholic: true,
    restaurant: restaurant
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    fill_in 'Buscar Item', with: 'macarrão'
    click_button 'Buscar'

    # Assert
    
    expect(page).to have_content("Macarrão Alho e Óleo")
    expect(page).not_to have_content("Salada Caesar")
    
  end

  it 'e não encontra resultados' do
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

    restaurant.dishes.create!(
      name: "Macarrão Alho e Óleo",
      description: "Prato de macarrão com alho, óleo e temperos"
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    fill_in 'Buscar Item', with: 'suco'
    click_button 'Buscar'

    # Assert
    expect(page).not_to have_content("Macarrão Alho e Óleo")
  end

  it 'e encontra vários resultados' do
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
    Beverage.create!(
    name: "Cerveja",
    description: "Bebida refrescante",
    alcoholic: true,
    restaurant: restaurant
    )

    Beverage.create!(
    name: "Vodka",
    description: "Nem um pouco refrescante",
    alcoholic: true,
    restaurant: restaurant
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    fill_in 'Buscar Item', with: 'refrescante'
    click_button 'Buscar'

    # Assert
    
    expect(page).to have_content("Cerveja")
    expect(page).to have_content("Vodka")
    expect(page).not_to have_content("Salada Caesar")
    
  end

  it 'e encontra resultados apenas do seu restaurante' do
    # Arrange
    user1 = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )

    user2 = User.create!(
      cpf: "090.195.910-37",
      email:  "kofi.annan@ri.com",
      name: "Kofi",
      last_name: "Annan",
      password: "nacoesunidas",
    )

    arvo = Restaurant.create!(
      user: user1,
      registered_name: "Arvo",
      comercial_name: "Arvo Restaurante",
      cnpj: "61.236.299/0001-72",
      address: "Av. 1000",
      phone: "6731423872",
      email: "arvo@restaurante.com"
    )

    reteteu = Restaurant.create!(
      user: user2,
      registered_name: "Reteteu",
      comercial_name: "Reteteu Restaurante",
      cnpj: "67.143.687/0001-95",
      address: "Av. Santos Dummont",
      phone: "8234711331",
      email: "reteteu@restaurante.com"
    )
    Beverage.create!(
    name: "Cerveja",
    description: "Bebida refrescante",
    alcoholic: true,
    restaurant: arvo
    )

    Beverage.create!(
      name: "Vodka",
      description: "Nem um pouco refrescante",
      alcoholic: true,
      restaurant: reteteu
    )

    # Act
    login_as(user1, :scope => :user)
    visit root_path
    fill_in 'Buscar Item', with: 'refrescante'
    click_button 'Buscar'

    # Assert
    
    expect(page).to have_content("Cerveja")
    expect(page).not_to have_content("Vodka")
    expect(page).not_to have_content("Salada Caesar")
    
  end

  it 'e encontra resultados baseado no nome e na descrição' do
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

    restaurant.dishes.create!(
      name: "Macarrão Alho e Óleo Refrescante",
      description: "Prato de macarrão com alho, óleo e temperos"
    )

    Beverage.create!(
      name: "Cerveja",
      description: "Bebida refrescante",
      alcoholic: true,
      restaurant: restaurant
    )

    Beverage.create!(
      name: "Vodka",
      description: "Muito forte",
      alcoholic: true,
      restaurant: restaurant
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    fill_in 'Buscar Item', with: 'refrescante'
    click_button 'Buscar'

    # Assert
    
    expect(page).to have_content "Macarrão Alho e Óleo Refrescante"
    expect(page).to have_content "Cerveja"
    expect(page).not_to have_content "Vodka"
    
  end

  it 'e consegue ver os detalhes o resultado da pesquisa' do
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
      name: "Macarrão Alho e Óleo Refrescante",
      description: "Prato de macarrão com alho, óleo e temperos",
      restaurant: restaurant
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    fill_in 'Buscar Item', with: 'Refrescante'
    click_button 'Buscar'
    click_on 'Macarrão Alho e Óleo Refrescante'

    # Assert
    expect(page).to have_content "Macarrão Alho e Óleo Refrescante"
    expect(page).to have_content "Prato de macarrão com alho, óleo e temperos"
    expect(current_path).to eq restaurant_dish_path(restaurant.id, dish.id)
  end

  it 'e consegue acessar diretamente a tela de edição do prato ou bebida.' do
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
      name: "Macarrão Alho e Óleo Refrescante",
      description: "Prato de macarrão com alho, óleo e temperos",
      restaurant: restaurant
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    fill_in 'Buscar Item', with: 'Refrescante'
    click_button 'Buscar'

    # Assert
    expect(page).to have_content "Macarrão Alho e Óleo Refrescante"
    expect(page).to have_content "Editar"

    # Act 2
    click_on "Editar"

    # Assert
    expect(current_path).to eq edit_restaurant_dish_path(restaurant.id, dish.id)
  end

  it 'e consegue fazer fluxo de pesquisa  e edição' do
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
      name: "Macarrão Alho e Óleo Refrescante",
      description: "Prato de macarrão com alho, óleo e temperos",
      restaurant: restaurant
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    fill_in 'Buscar Item', with: 'Refrescante'
    click_button 'Buscar'
    click_on "Editar"
    fill_in 'Descrição', with: 'Prato de macarrão com alho, óleo e temperos picantes'
    click_on 'Atualizar Prato'
    fill_in 'Buscar Item', with: 'picantes'
    click_button 'Buscar'
    click_on 'Macarrão Alho e Óleo Refrescante'

    # Assert
    expect(page).to have_content "Macarrão Alho e Óleo Refrescante"
    expect(page).to have_content "Prato de macarrão com alho, óleo e temperos picantes"
  end

end
