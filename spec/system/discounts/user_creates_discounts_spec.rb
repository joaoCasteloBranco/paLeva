require 'rails_helper'

describe 'Usuário cria descontos' do
  it 'e com sucesso sem limite de uso' do
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
    click_on "Adicionar Desconto"
    fill_in "Nome do Desconto", with: "Semana do Suco"
    fill_in "Valor", with: 10
    fill_in "Data de Início", with: Date.today - 2.week
    fill_in "Data de Fim", with: Date.today + 2.week
    click_on "Adicionar"

    discount = Discount.all.last

    expect(discount.name).to eq "Semana do Suco"
    expect(discount.value).to eq 10
    expect(discount.start_date).to eq Date.today - 2.week
    expect(discount.end_date).to eq Date.today + 2.week

  end

  it 'e com sucesso com limite de uso' do
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
    click_on "Adicionar Desconto"
    fill_in "Nome do Desconto", with: "Semana do Suco"
    fill_in "Valor", with: 10
    fill_in "Data de Início", with: Date.today - 2.week
    fill_in "Data de Fim", with: Date.today + 2.week
    fill_in "Limite de Uso", with: 100
    click_on "Adicionar"

    discount = Discount.all.last

    expect(discount.name).to eq "Semana do Suco"
    expect(discount.value).to eq 10
    expect(discount.start_date).to eq Date.today - 2.week
    expect(discount.end_date).to eq Date.today + 2.week

  end

  it 'mas falha sem nome' do
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
    click_on "Adicionar Desconto"

    fill_in "Valor", with: 10
    fill_in "Data de Início", with: Date.today - 2.week
    fill_in "Data de Fim", with: Date.today + 2.week
    fill_in "Limite de Uso", with: 100
    click_on "Adicionar"

    expect(page).to have_content "Não foi possível cadastrar o desconto!"

  end
end