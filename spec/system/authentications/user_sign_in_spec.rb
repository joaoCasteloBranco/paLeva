require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do 
    # Arrange
    User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
    # Act
    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    fill_in 'E-mail', with: "sergio.vieira.de.melo@ri.com"
    fill_in 'Senha', with: "nacoesunidas"
    click_on 'Entrar'

    # Assert
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_link 'Sair'
      
  end
end