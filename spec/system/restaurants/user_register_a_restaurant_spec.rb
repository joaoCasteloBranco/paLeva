require 'rails_helper'

describe 'Usuário cadastra um restaurante' do
  it 'mas não está autenticado' do
    # Arrange 

    # Act
    visit root_path

    # Assert
    expect(page).not_to have_content 'Cadastrar Restaurante'

  end

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

    # Assert
    expect(page).to have_content "Arvo"
  end

  it 'mas com falha' do
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
    fill_in 'Razão Social', with: nil
    fill_in 'CNPJ', with: nil
    fill_in 'Endereço Completo', with: nil
    fill_in 'Telefone', with: nil
    fill_in 'E-mail', with: nil 
    click_on 'Adicionar Restaurante'

    # Assert
    expect(page).to have_content "Não foi possível registrar o restaurante"
    expect(page).not_to have_content "Arvo"
  end

  it 'E possui um código único' do
    # Arrange
    user_1 = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
  
    restaurant_1 = Restaurant.create!(
      user: user_1,
      registered_name: "Arvo",
      comercial_name: "Arvo Restaurante",
      cnpj: "61.236.299/0001-72",
      address: "Av. 1000",
      phone: "6731423872",
      email: "arvo@restaurante.com"
    )
  
    user_2 = User.create!(
      cpf: "662.142.320-99",
      email:  "email@email.com",
      name: "Usuário",
      last_name: "Teste",
      password: "nacoesunidas",
    )
  
    restaurant_2 = Restaurant.create!(
      user: user_2,
      registered_name: "Reteteu",
      comercial_name: "Reteteu Restaurante",
      cnpj: "50.934.557/0001-78",
      address: "Av. 1000",
      phone: "6731423872",
      email: "reteteu@restaurante.com"
    )

    # Act
    # Assert
    expect(restaurant_1.code).not_to eq restaurant_2.code
  end

  it 'e só é possível um usuário cadastrar dado restaurante' do
    # Arrange
    user_1 = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )

    user_2 = User.create!(
      cpf: "662.142.320-99",
      email:  "email@email.com",
      name: "Usuário",
      last_name: "Teste",
      password: "nacoesunidas",
    )
  
    restaurant = Restaurant.create!(
      user: user_1,
      registered_name: "Arvo",
      comercial_name: "Arvo Restaurante",
      cnpj: "61.236.299/0001-72",
      address: "Av. 1000",
      phone: "6731423872",
      email: "arvo@restaurante.com"
    )
  
    # Act

    login_as(user_2, :scope => :user)
    visit root_path
    click_on 'Cadastrar Restaurante'
    fill_in 'Nome Fantasia', with: "Arvo"
    fill_in 'Razão Social', with: "Arvo Restaurante"
    fill_in 'CNPJ', with: "61.236.299/0001-72"
    fill_in 'Endereço Completo', with: "Av. 1000"
    fill_in 'Telefone', with: "6731423872"
    fill_in 'E-mail', with: "arvo@restaurante.com"
    click_on 'Adicionar Restaurante'

    # Assert
    expect(page).to have_content "Não foi possível registrar o restaurante"
    expect(page).not_to have_content "Arvo"
  end

end