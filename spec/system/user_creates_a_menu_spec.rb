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

    serving = Serving.create!(
      menu_item: dish,
      price: 2000,
      description: 'Porção Teste (1200g)'
    )

    # Act
    login_as(user)
    visit root_path
    click_on 'Adicionar Cardápio'
    fill_in "Nome", with: "Almoço Executivo"
    click_on "Adicionar Cardápio"

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content "Almoço Executivo"

  end
end
