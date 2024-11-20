require 'rails_helper'

describe 'Usuário edita um restaurante' do
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
    fill_in 'CNPJ', with: "61.236.299/0001-72"
    fill_in 'Endereço Completo', with: "Av. 1000"
    fill_in 'Telefone', with: "6731423872"
    fill_in 'E-mail', with: "arvo@restaurante.com"
    click_on 'Adicionar Restaurante'
    click_on 'Restaurante'
    click_on 'Editar Restaurante'
    fill_in 'Endereço Completo', with: "Av. 2000"
    click_on 'Atualizar Restaurante'

    # Assert
    expect(page).to have_content "Restaurante Atualizado com Sucesso"
    expect(page).to have_content "Arvo"
    expect(page).to have_content "Av. 2000"
    expect(page).not_to have_content "Av. 1000"
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

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Cadastrar Restaurante'
    fill_in 'Nome Fantasia', with: "Arvo"
    fill_in 'Razão Social', with: "Arvo Restaurante"
    fill_in 'CNPJ', with: "61.236.299/0001-72"
    fill_in 'Endereço Completo', with: "Av. 1000"
    fill_in 'Telefone', with: "6731423872"
    fill_in 'E-mail', with: "arvo@restaurante.com"
    click_on 'Adicionar Restaurante'
    click_on 'Restaurante'
    click_on 'Editar Restaurante'
    fill_in 'Endereço Completo', with: "Av. 2000"
    fill_in 'Telefone', with: nil
    click_on 'Atualizar Restaurante'

    # Assert
    expect(page).to have_content "Não foi possível atualizar o restaurante"
    expect(page).not_to have_content "Av. 2000"

  end
end