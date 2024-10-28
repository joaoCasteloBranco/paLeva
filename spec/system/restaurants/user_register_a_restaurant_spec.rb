require 'rails_helper'

describe 'Usuário cadastra um restaurante' do
  it 'e com sucesso' do
    # Arrange
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Cadastrar Restaurante'
    fill_in 'Nome Fantasia', with: "Arvo"
    fill_in 'Razão Social', with: "Arvo Restaurante"
    fill_in 'Nome Fantasia', with: "61.236.299/0001-72"
    fill_in 'Endereço Completo', with: "Av. 1000"
    fill_in 'Telefone', with: "(67) 3142-3872"
    fill_in 'E-mail', with: "arvo@restaurante.com"
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content "Arvo"
  end
end