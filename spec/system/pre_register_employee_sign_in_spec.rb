require 'rails_helper'

describe 'Funcionário Pré-cadastrado se cadastra' do 
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

    employee = Employee.create!(
      cpf: "662.142.320-99",
      email: "email@email.com",
      status: :pre_registered,
      restaurant: restaurant
    )

    # Act
    visit root_path
    click_on 'Área Funcionários'
    click_on 'Sign up'
    fill_in 'Email', with: "email@email.com"
    fill_in 'Cpf', with: "662.142.320-99"
    fill_in 'Nome', with: "Usuario"
    fill_in 'employee_password', with: "nacoesunidas"
    fill_in 'employee_password_confirmation', with: "nacoesunidas"
    click_on 'Criar conta'
  
    # Assert
    expect(page).to have_content 'Cadastro concluído com sucesso.'
    expect(page).not_to have_content 'Email ou CPF inválidos ou não encontrados.'

    expect(page).to have_button 'Sair'
    expect(page).not_to have_link 'Entrar'

    employee = Employee.last

    expect(employee.name).to eq 'Usuario'
    expect(employee.status).to eq "active"
    expect(employee.restaurant).to eq restaurant

  end
end