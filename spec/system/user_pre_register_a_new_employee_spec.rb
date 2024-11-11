require 'rails_helper'

describe 'Usuário registra um funcionário' do 
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
    click_on 'Ver Funcionários Cadastrados'
    click_on 'Adicionar novo funcionário'
    fill_in "E-mail", with: "email@email.com"
    fill_in "CPF", with: "662.142.320-99"
    click_on 'Pré-Cadastrar'

    # Assert
    expect(page).to have_content 'Funcionário pré-cadastrado com sucesso.'
    expect(page).to have_content 'email@email.com'
    expect(page).to have_content '662.142.320-99'

  end
end
