require 'rails_helper'

describe 'Usuário realiza pré cadastro' do 
  it 'e visualiza com sucesso' do
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
    click_on 'Funcionários'
    click_on 'Adicionar novo funcionário'
    fill_in "E-mail", with: "email@email.com"
    fill_in "CPF", with: "662.142.320-99"
    click_on 'Pré-Cadastrar'

    # Assert
    expect(page).to have_content 'Funcionário pré-cadastrado com sucesso.'
    expect(page).to have_content 'email@email.com'
    expect(page).to have_content '662.142.320-99'

  end

  it 'e visualiza com sucesso mais de um usuário' do
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

    employee = Employee.create!(
      cpf: "662.142.320-99",
      email: "email@email.com",
      status: :pre_registered,
      restaurant: restaurant
    )

    employee = Employee.create!(
      cpf: "165.180.750-74",
      email: "email2@email.com",
      status: :pre_registered,
      restaurant: restaurant
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Funcionários'


    # Assert
    expect(page).to have_content 'email@email.com'
    expect(page).to have_content '662.142.320-99'

    expect(page).to have_content "email2@email.com"
    expect(page).to have_content '165.180.750-74'

  end

  it 'e visualiza usuário que já completaram o cadastro e que não completaram' do
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

    employee = Employee.create!(
      cpf: "662.142.320-99",
      email: "email@email.com",
      status: :pre_registered,
      restaurant: restaurant
    )

    employee = Employee.create!(
      cpf: "165.180.750-74",
      email: "email2@email.com",
      status: :active,
      restaurant: restaurant,
      password: "nacoesunidas"
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Funcionários'


    # Assert
    within("#active_employees") do
      expect(page).to have_content "email2@email.com"
      expect(page).to have_content '165.180.750-74'
    end
    
    expect(page).to have_content 'email@email.com'
    expect(page).to have_content '662.142.320-99'

  end
end