require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    # Arrange

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    fill_in 'Senha', with: "nacoesunidas"
    fill_in 'Nome', with: "Sergio"
    fill_in 'CPF', with: "109.789.030-99"
    fill_in 'Sobrenome', with: "Vieira"
    fill_in 'E-mail', with: "sergio.vieira.de.melo@ri.com"
    fill_in 'Confirme sua senha', with: "nacoesunidas"
    click_on 'Criar conta'
    
    # Assert
    expect(page).to have_button 'Sair'
    expect(page).not_to have_button 'Entrar'
    user = User.last
    expect(user.name).to eq 'Sergio'

  end
end