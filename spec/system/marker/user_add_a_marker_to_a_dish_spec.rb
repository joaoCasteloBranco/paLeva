require 'rails_helper'

describe 'Usuário adiciona um macardor já cadastrado a um prato' do
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

    dish = Dish.create!(
      restaurant: restaurant, 
      name: "Prato Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300
      
    )

    marker = Marker.create!(
      name: "Vegano",
      restaurant: restaurant
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Ver Restaurante"
    end
    click_on "Prato Teste"
    click_on 'Editar Prato'
    check "Vegano"
    click_on 'Atualizar Prato'   
    
    # Assert
    expect(current_path).to eq restaurant_dish_path(restaurant.id, dish.id)
    expect(page).to have_content("Vegano")


  end 

  it 'e adiciona apenas um marcador' do
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

    marker_1 = Marker.create!(
      name: "Vegano",
      restaurant: restaurant
    )

    marker_2 = Marker.create!(
      name: "Picante",
      restaurant: restaurant
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Ver Restaurante"
    end
    click_on "Prato Teste"
    click_on 'Editar Prato'
    check "Picante"
    click_on 'Atualizar Prato'    

    # Assert
    expect(current_path).to eq restaurant_dish_path(restaurant.id, dish.id)
    expect(page).not_to have_content "Vegano"
    expect(page).to have_content "Picante"

  end 

 
  it 'e não cadastra nenhum marcador' do
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

    marker_1 = Marker.create!(
      name: "Vegano",
      restaurant: restaurant
    )

    marker_2 = Marker.create!(
      name: "Picante",
      restaurant: restaurant
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Ver Restaurante"
    end
    click_on "Prato Teste"
    click_on 'Editar Prato'
    click_on 'Atualizar Prato'    

    # Assert
    expect(current_path).to eq restaurant_dish_path(restaurant.id, dish.id)
    expect(page).not_to have_content "Vegano"
    expect(page).not_to have_content "Picante"

  end 
  
end