require 'rails_helper'

describe 'Usuário adiciona porção para o pedido' do 
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


    order = Order.create!(
      restaurant: restaurant,
      customer_name: 'João',
      contact_phone: "6731423872",
      contact_email: 'joao.silva@email.com',
      cpf: '109.789.030-99',
    )

    # Act 
    login_as(user, :scope => :user)
    visit root_path
    click_on "Ver Pedidos"
    click_on "joao.silva@email.com"
    click_on "Adicionar Porções ao Pedido"

    select 'Porção Teste (600g)'
    click_on "Adicionar ao Pedido"

    # Assert
    expect(page).to have_content 'Porção Teste (600g)'
    expect(page).to have_content "Preço: R$ 10,00"

    
  end
end