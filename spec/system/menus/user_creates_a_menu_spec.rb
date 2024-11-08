require 'rails_helper'

describe 'Usuário cria um cardápio' do
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
    login_as(user)
    visit root_path
    click_on 'Adicionar Cardápio'
    fill_in "Nome", with: "Almoço Executivo"
    click_on "Adicionar"

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content "Almoço Executivo"
    expect(page).to have_content "Cardápio criado com sucesso"

  end

  it 'mas falha ao criar com nome duplicado' do
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
    fill_in "Nome", with: "Almoço Executivo"
    click_on "Adicionar"

    # Assert
    expect(page).to have_content "falha ao criar o cardápio"

  end

  it 'com sucesso ao criar dois cardápios com nomes iguais, mas para restaurantes diferentes' do
    # Arrange
    user_1 = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
  
    restaurant_1 = Restaurant.create!(
      user: user_1,
      registered_name: "Arvo",
      comercial_name: "Arvo Restaurante",
      cnpj: "61.236.299/0001-72",
      address: "Av. 1000",
      phone: "6731423872",
      email: "arvo@restaurante.com"
    )

    menu_1 = Menu.create!(
      name: "Nome Igual",
      restaurant: restaurant_1
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
    login_as(user_2)
    visit root_path
    
    click_on 'Adicionar Cardápio'
    fill_in "Nome", with: "Nome Igual"
    click_on "Adicionar"

    # Assert
    expect(page).to have_content "Cardápio criado com sucesso"
    expect(page).to have_content "Nome Igual"
    expect(current_path).to eq root_path  

  end

  it 'mas falha ao criar cardáio sem nome' do
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
    fill_in "Nome", with: nil
    click_on "Adicionar"

    # Assert
    expect(page).to have_content "falha ao criar o cardápio"

  end

  it 'e só consegue ver cardápios do seu restaurante' do
    # Arrange
    user_1 = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
  
    restaurant_1 = Restaurant.create!(
      user: user_1,
      registered_name: "Arvo",
      comercial_name: "Arvo Restaurante",
      cnpj: "61.236.299/0001-72",
      address: "Av. 1000",
      phone: "6731423872",
      email: "arvo@restaurante.com"
    )

    menu_1 = Menu.create!(
      name: "Menu Restaurante 1",
      restaurant: restaurant_1
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

    menu_2 = Menu.create!(
      name: "Menu Restaurante 2",
      restaurant: restaurant_2
    )

    # Act
    login_as(user_2)
    visit restaurant_menu_path(restaurant_1.id, menu_1.id)
  

    # Assert
    expect(page).to have_content "Acesso negado"
    expect(page).not_to have_content "Menu Restaurante 1"


    expect(current_path).to eq root_path  

  end
end
