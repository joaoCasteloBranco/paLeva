require 'rails_helper'

describe 'Usuário cadastra um prato' do
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

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Ver Restaurante"
    end
    click_on "Adicionar um prato"
    fill_in 'Nome', with: 'Prato Teste'
    fill_in 'Descrição', with: 'Uma descrição do prato de teste.'
    fill_in 'Calorias', with: 300
    click_on 'Adicionar Prato'
  
    # Assert

    expect(page).to have_content('Prato Criado com sucesso!')
    expect(page).to have_content('Prato Teste')
  end

  it 'e não consegue fazer o cadastro' do
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
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Ver Restaurante"
    end
    click_on "Adicionar um prato"
    fill_in 'Nome', with: 'Prato Teste'
    fill_in 'Calorias', with: 300
    fill_in 'Descrição', with: nil
    click_on 'Adicionar Prato'
  
    # Assert

    expect(page).not_to have_content('Prato Criado com sucesso!')
    expect(page).not_to have_content('Prato Teste')
    expect(page).to have_content "Não foi possível cadastrar o prato!"
  end

  it 'e tenta ver prato de outro usuário' do
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

    user_2 = User.create!(
      cpf: "662.142.320-99",
      email:  "email@email.com",
      name: "Usuário",
      last_name: "Teste",
      password: "nacoesunidas",
    )

    restaurant_2 = Restaurant.create!(
      user: user_2,
      registered_name: "Reteteu",
      comercial_name: "Reteteu Restaurante",
      cnpj: "50.934.557/0001-78",
      address: "Av. 1000",
      phone: "6731423872",
      email: "reteteu@restaurante.com"
    )

    # Act
    login_as(user_2, :scope => :user)
    visit root_path
    visit restaurant_dish_path(restaurant.id, dish.id)
  
    # Assert

    expect(page).not_to have_content "Arvo Restaurante"
    expect(page).to have_content 'Acesso negado!'
  end
end