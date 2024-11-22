require 'rails_helper'

describe 'Usuário adiciona cria um pedido com descontos' do 
  it 'e com sucesso' do 
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

    serving_1 = Serving.create!(
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

    order_item = OrderItem.create!(
      order: order,
      serving: serving_1,
      note: "Sem Cebola"
    )

    discount = Discount.create!(
      restaurant: restaurant,
      name: "Semana do Suco",
      start_date: Date.today - 2.week,
      end_date: Date.today + 2.week,
      value: 10
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Restaurante"
    end


    click_on "Semana do Suco"
    
    click_on "Adicionar Porções"
    choose 'Porção Teste (600g)'
    click_on 'Adicionar'

    within('nav') do
      click_on "Pedidos"
    end

    click_on 'joao.silva@email.com'

    # Assert

    expect(order.total_price).to eq 10
    expect(order.total_price_with_discount).to eq 9

  end
end