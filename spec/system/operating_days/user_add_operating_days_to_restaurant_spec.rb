require 'rails_helper'

describe 'Usuário adiciona dias de operação para o restaurante' do 
  it 'com sucesso' do
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
    within('nav') do
      click_on "Ver Restaurante"
    end
    click_on 'Adicionar Horário de Funcionamento'
    select "monday", from: "week_day"
    check 'Fechado'
    fill_in 'Horário de Abertura', with: '06:00'
    fill_in 'Horário de Fechamento', with: '18:00'
    click_on 'Gravar Horário'

    # Assert
    expect(page).to have_content 'Horário Adicionado'
    
  end
end