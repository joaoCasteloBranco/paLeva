require 'rails_helper'

describe 'Usuário deleta uma bebida' do
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
      click_on "Ver Restaurante"
    end
    click_on "Adicionar uma bebida"
    fill_in 'Nome', with: 'Bebida Teste'
    fill_in 'Descrição', with: 'Uma descrição da bebida de teste.'
    fill_in 'Calorias', with: 300
    check 'Alcólica?'
    click_on 'Salvar Bebida'
    click_on 'Bebida Teste'
    click_on 'Excluir Bebida'
  
    # Assert

    expect(page).not_to have_content 'Bebida Teste'
    expect(page).not_to have_content 'Uma descrição da bebida de teste.'
  end

end