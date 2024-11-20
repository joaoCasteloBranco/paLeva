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
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Restaurante"
    end
    click_on 'Adicionar Horário de Funcionamento'
    select "Segunda", from: "Dia da Semana"
    check 'Aberto?'
    fill_in 'Horário de Abertura', with: '06:00'
    fill_in 'Horário de Fechamento', with: '18:00'
    click_on 'Adicionar Dia de Operação'

    # Assert
    expect(page).to have_content 'Horário Adicionado'
    expect(page).to have_content '06:00'
    expect(page).to have_content '18:00'

  end

  it 'e adiciona um dia como fechado' do
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
    click_on 'Adicionar Horário de Funcionamento'
    select "Segunda", from: "Dia da Semana"
    click_on 'Adicionar Dia de Operação'

    # Assert
    expect(page).to have_content 'Horário Adicionado'
    expect(page).to have_content 'Segunda'
    expect(page).to have_content 'Fechado'

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
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Restaurante"
    end
    click_on 'Adicionar Horário de Funcionamento'
    select "Segunda", from: "Dia da Semana"
    check 'Aberto?'
    fill_in 'Horário de Abertura', with: '06:00'
    fill_in 'Horário de Fechamento', with: '18:00'
    click_on 'Adicionar Dia de Operação'
    click_on 'Segunda'

    # Assert
    expect(page).to have_content 'Horário de Funcionamento: Segunda'
    expect(page).to have_content '06:00'
    expect(page).to have_content '18:00'
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

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Restaurante"
    end
    click_on 'Adicionar Horário de Funcionamento'
    select "Segunda", from: "Dia da Semana"
    check 'Aberto?'

    click_on 'Adicionar Dia de Operação'

    # Assert
    expect(page).not_to have_content 'Horário Atualizado'
    expect(page).to have_content 'Falha ao adicionar o horário'
    expect(page).not_to have_content 'Horário de Funcionamento: Segunda'
    expect(page).not_to have_content '06:00'
    expect(page).not_to have_content '18:00'
  end

  it 'mas falha por horário de fechamento após horário de abertura' do
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
    click_on 'Adicionar Horário de Funcionamento'
    select "Segunda", from: "Dia da Semana"
    check 'Aberto?'
    fill_in 'Horário de Abertura', with: '18:00'
    fill_in 'Horário de Fechamento', with: '06:00'
    click_on 'Adicionar Dia de Operação'

    # Assert
    expect(page).not_to have_content 'Horário Atualizado'
    expect(page).to have_content 'Falha ao adicionar o horário'
    expect(page).not_to have_content 'Horário de Funcionamento: Segunda'
  end

  it 'e adiciona todos os dias da semana' do
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

    OperatingDay.create!(week_day: :sunday, restaurant: restaurant, open: false)
    OperatingDay.create!(week_day: :monday, restaurant: restaurant, open: false)
    OperatingDay.create!(week_day: :tuesday, restaurant: restaurant, open: false)
    OperatingDay.create!(week_day: :wednesday, restaurant: restaurant, open: false)
    OperatingDay.create!(week_day: :thursday, restaurant: restaurant, open: false)
    OperatingDay.create!(week_day: :friday, restaurant: restaurant, open: false)
    OperatingDay.create!(week_day: :saturday, restaurant: restaurant, open: false)

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Restaurante"
    end
       
    # Assert
    expect(page).not_to have_content 'Adicionar Horário de Funcionamento'
  end
end