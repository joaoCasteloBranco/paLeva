require 'rails_helper'

describe 'Usuário deleta um restaurante' do
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
    click_on 'Restaurante'
    click_on 'Deletar Restaurante'

    # Assert
    expect(page).to have_content "Restaurante Excluido com Sucesso"
    expect(page).not_to have_content "Arvo"
    expect(page).not_to have_content "Av. 1000"
    expect(page).not_to have_content "61.236.299/0001-72"
    within( "nav") do
      expect(page).to have_content "Cadastrar Restaurante"
    end
    

  end

end