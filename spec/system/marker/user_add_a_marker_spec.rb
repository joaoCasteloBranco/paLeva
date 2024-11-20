require 'rails_helper'

describe 'Usuário cria um marcador' do
  it 'e  com sucesso' do
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
      click_on "Restaurante"
    end
    click_on "Adicionar um Marcador"
    fill_in "Nome do Marcador", with: "Vegano"
    click_on "Adicionar"

    # Assert
    expect(page).to have_content "Marcador salvo com sucesso"
    expect(page).to have_content "Vegano"

  end 

  it 'e só é valido para o seu restaurante' do
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
      email: "arvo@restaurante.com"
    )

    marker = Marker.create!(name: "Apimentado", restaurant: restaurant_1)

    # Act
    login_as(user_2, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Restaurante"
    end
    
    # Assert
    expect(page).not_to have_content "Apimentado"

  end  
  
  
end