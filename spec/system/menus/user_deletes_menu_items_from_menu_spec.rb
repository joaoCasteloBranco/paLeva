require 'rails_helper'

describe 'Usuário exclui um item de menu do cardápio' do
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

    beverage_exlcude = Beverage.create!(
      restaurant: restaurant, 
      name: "Bebida a ser Excluida",
      description: 'Uma descrição do prato de teste.',
      calories: 300,
      alcoholic: false
    )

    MenuContent.create!(
      menu: menu,
      menu_item: beverage_exlcude
    )

    # Act
    login_as(user)
    visit root_path
    click_on "Almoço executivo"

    within "#menu_item_#{beverage_exlcude.id}" do
      click_on 'Excluir'
    end

    # Arrange
    expect(page).to have_content "Prato excluído com sucesso do cardápio!"
    expect(page).to have_content "Bebida Teste"
    expect(page).not_to have_content "Bebida a ser Excluida"

  end
end