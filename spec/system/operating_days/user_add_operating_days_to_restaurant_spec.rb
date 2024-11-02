require 'rails_helper'

describe 'Usuário adiciona dias de operação para o restaurante' do 
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
    within('nav') do
      click_on "Ver Restaurante"
    end
    click_on 'Adicionar Horário de Funcionamento'
    select "monday", from: "Dia da Semana"
    check 'Aberto?'
    fill_in 'Horário de Abertura', with: '06:00'
    fill_in 'Horário de Fechamento', with: '18:00'
    click_on 'Adicionar Dia de Operação'

    # Assert
    expect(page).to have_content 'Horário Adicionado'
    expect(page).to have_content '06:00'
    expect(page).to have_content '18:00'

  end

  it 'e vai para a página de detalhes do horário' do
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
    select "monday", from: "Dia da Semana"
    check 'Aberto?'
    fill_in 'Horário de Abertura', with: '06:00'
    fill_in 'Horário de Fechamento', with: '18:00'
    click_on 'Adicionar Dia de Operação'
    click_on 'monday'

    # Assert
    expect(page).to have_content 'Horário de Funcionamento: monday'
    expect(page).to have_content '06:00'
    expect(page).to have_content '18:00'

  end
end