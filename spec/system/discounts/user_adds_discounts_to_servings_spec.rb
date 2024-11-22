require 'rails_helper'

describe 'Usuário adiciona Porções a um desconto' do 
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

    discount = Discount.create!(
      restaurant: restaurant,
      name: "Semana do Suco",
      start_date: Date.today - 2.week,
      end_date: Date.today + 2.week,
      value: 10
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

    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Restaurante"
    end
    click_on "Semana do Suco"
    click_on "Adicionar Porções"
    choose 'Porção Teste (600g)'
    click_on 'Adicionar'
    click_on "Semana do Suco"

    expect(page).to have_content 'Porção Teste (600g)'

  end
end