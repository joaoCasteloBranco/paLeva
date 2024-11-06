require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso e' do 
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
    within('form') do
      fill_in 'E-mail', with: "sergio.vieira.de.melo@ri.com"
      fill_in 'Senha', with: "nacoesunidas"
      click_on 'Entrar'
    end

    # Assert
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_button 'Sair'
      
  end

  it 'e faz logout' do
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
    within('form') do
      fill_in 'E-mail', with: "sergio.vieira.de.melo@ri.com"
      fill_in 'Senha', with: "nacoesunidas"
      click_on 'Entrar'
    end
    within('nav') do
      click_on 'Sair'
    end

    # Assert
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
  end

  it 'com sucesso e é movido para a página de cadastrar um restaurante' do 
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
    within('form') do
      fill_in 'E-mail', with: "sergio.vieira.de.melo@ri.com"
      fill_in 'Senha', with: "nacoesunidas"
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content 'Registro Restaurante'
      
  end

  it 'mas falha' do 
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
    within('form') do
      fill_in 'E-mail', with: "sergio.vieira.de.melo@ri.com"
      fill_in 'Senha', with: "wrong_password"
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content 'E-mail ou senha inválidos'
    expect(page).not_to have_content 'Registro Restaurante'
      
  end

end