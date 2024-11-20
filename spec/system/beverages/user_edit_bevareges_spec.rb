require 'rails_helper'

describe 'Usuário edita uma bebida' do
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

    beverage = Beverage.create!(
      restaurant: restaurant, 
      name: "Bebida Teste",
      description: 'Uma descrição da Bebida de teste.',
      calories: 300,
      alcoholic: false
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Restaurante"
    end
    click_on 'Bebida Teste'
    click_on 'Editar Bebida'
    fill_in 'Descrição', with: 'Outra descrição'
    click_on 'Atualizar Bebida'

  
    # Assert

    expect(page).to have_content 'Bebida atualizada com sucesso!'
    expect(page).to have_content 'Outra descrição'
    expect(page).not_to have_content 'Uma descrição da bebida de teste.'
  end

  it 'mas falha' do
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

    beverage = Beverage.create!(
      restaurant: restaurant, 
      name: "Bebida Teste",
      description: 'Uma descrição da Bebida de teste.',
      calories: 300,
      alcoholic: false
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Restaurante"
    end
    click_on 'Bebida Teste'
    click_on 'Editar Bebida'
    fill_in 'Descrição', with: nil
    click_on 'Atualizar Bebida'

    # Assert

    expect(page).not_to have_content 'Bebida atualizada com sucesso!'
    expect(page).not_to have_content 'Outra descrição'
    expect(page).to have_content 'Bebida não atualizada.'

  end

  it 'e tenta editar prato de outro usuário' do
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

    beverage = Beverage.create!(
      restaurant: restaurant, 
      name: "Bebida Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300,
      alcoholic: false
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
    visit edit_restaurant_beverage_path(restaurant.id, beverage.id)
  
    # Assert
    expect(page).not_to have_content 'Bebida Teste'
    expect(page).to have_content 'Acesso negado!'
  end

end