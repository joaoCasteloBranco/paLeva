require 'rails_helper'

describe 'Funcionário não cadastrado tenta o login' do 
  it 'e falha' do
    # Arrange


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
    expect(page).not_to have_content 'Funcionário pré-cadastrado com sucesso.'
    expect(page).not_to have_content 'email@email.com'
    expect(page).not_to have_content '662.142.320-99'
    expect(page).to have_content(
      'Email ou CPF inválidos ou não foram pré-cadastrados. Verifique com a administração do Restaurante'
    ) 

  end

end
