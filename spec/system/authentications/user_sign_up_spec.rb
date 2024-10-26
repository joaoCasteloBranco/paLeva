require 'rails_helper'

describe 'Usuário vai se autenticar' do
  it 'e se autentica com sucesso' do
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
    expect(page).not_to have_link 'Entrar'
    user = User.last
    expect(user.name).to eq 'Sergio'

  end

  it 'e não consegue se registrar por ter uma senha curta' do
    # Arrange  

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    fill_in 'CPF', with: '109.789.030-99'
    fill_in 'Nome', with: 'João'
    fill_in 'Sobrenome', with: 'Silva'
    fill_in 'E-mail', with: 'joao.silva@example.com'
    fill_in 'Senha', with: 'curta'
    fill_in 'Confirme sua senha', with: 'curta'
    click_on 'Criar conta'

    # Assert
    expect(page).not_to have_button 'Sair'
    expect(page).to have_link 'Entrar'
  end

  it 'e não consegue se registrar por usar um cpf já registrado' do
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
    click_on 'Entrar'
    click_on 'Criar conta'
    fill_in 'CPF', with: '109.789.030-99' 
    fill_in 'Nome', with: 'João'
    fill_in 'Sobrenome', with: 'Silva'
    fill_in 'E-mail', with: 'joao.silva@email.com'
    fill_in 'Senha', with: 'nacoesunidas'
    fill_in 'Confirme sua senha', with: 'nacoesunidas'
    click_on 'Criar conta'

    # Assert
    expect(page).not_to have_button 'Sair'
    expect(page).to have_link 'Entrar'
  end

  it 'e não consegue se registar por ter um cpf invalido' do
    # Arrange 

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    fill_in 'CPF', with: '123.456.789-00' # CPF inválido
    fill_in 'Nome', with: 'João'
    fill_in 'Sobrenome', with: 'Silva'
    fill_in 'E-mail', with: 'joao.silva@example.com'
    fill_in 'Senha', with: 'nacoesunidas'
    fill_in 'Confirme sua senha', with: 'nacoesunidas'
    click_on 'Criar conta'

    # Assert
    expect(page).not_to have_button 'Sair'
    expect(page).to have_link 'Entrar'
  end
end