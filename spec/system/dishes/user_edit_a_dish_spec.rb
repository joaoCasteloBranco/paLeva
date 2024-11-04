require 'rails_helper'

describe 'Usuário edita um prato' do
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

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Ver Restaurante"
    end
    click_on 'Prato Teste'
    click_on 'Editar Prato'
    fill_in 'Descrição', with: 'Outra descrição'
    click_on 'Atualizar Prato'
  
    # Assert

    expect(page).not_to have_content 'Uma descrição do prato de teste.'
    expect(page).to have_content 'Outra descrição'
    expect(page).to have_content 'Prato atualizado com sucesso!'
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
 
    dish = Dish.create!(
      restaurant: restaurant, 
      name: "Prato Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Ver Restaurante"
    end
    click_on 'Prato Teste'
    click_on 'Editar Prato'
    fill_in 'Descrição', with: nil
    click_on 'Atualizar Prato'
  
    # Assert
    expect(page).not_to have_content 'Outra descrição'
    expect(page).to have_content 'Prato não Atualizado.'
  end

end