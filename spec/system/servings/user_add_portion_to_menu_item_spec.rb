require 'rails_helper'

describe 'Usuário adiciona porção para um item do cardápio' do
  it 'e  com sucesso a um prato' do
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
    click_on "Adicionar um prato"
    fill_in 'Nome', with: 'Prato Teste'
    fill_in 'Descrição', with: 'Uma descrição do prato de teste.'
    fill_in 'Calorias', with: 300
    click_on 'Adicionar Prato'
    click_on 'Prato Teste'
    click_on 'Cadastrar Porção'
    fill_in 'Descrição', with: 'Porção Teste (600g)'
    fill_in 'Preço', with: 1000
    click_on 'Cadastrar'
    

    # Assert
    expect(page).to have_content "Cadastrado com sucesso"
    expect(page).to have_content "Porção Teste (600g)"
    expect(page).to have_content "Preço: R$ 10,00"

  end

  it 'e  com sucesso a uma bebida' do
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
   click_on 'Adicionar Bebida'
   click_on 'Bebida Teste'
   click_on 'Cadastrar Embalagem'
   fill_in 'Descrição', with: 'Garrafa 150ml'
   fill_in 'Preço', with: 2000
   click_on 'Cadastrar'
   

   # Assert
   expect(page).to have_content "Cadastrado com sucesso"
   expect(page).to have_content "Garrafa 150ml"
   expect(page).to have_content "Preço: R$ 20,00"

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
    click_on "Adicionar um prato"
    fill_in 'Nome', with: 'Prato Teste'
    fill_in 'Descrição', with: 'Uma descrição do prato de teste.'
    fill_in 'Calorias', with: 300
    click_on 'Adicionar Prato'
    click_on 'Prato Teste'
    click_on 'Cadastrar Porção'
    fill_in 'Descrição', with: nil
    fill_in 'Preço', with: 1000
    click_on 'Cadastrar'
    

    # Assert
    expect(page).to have_content "Não foi possível realizar o cadastro"
    expect(page).not_to have_content "Porção Teste (600g)"
    expect(page).not_to have_content "Preço: R$ 10,00"

  end

  it 'e adiciona mais uma porção' do
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
   click_on "Adicionar um prato"
   fill_in 'Nome', with: 'Prato Teste'
   fill_in 'Descrição', with: 'Uma descrição do prato de teste.'
   fill_in 'Calorias', with: 300
   click_on 'Adicionar Prato'
   click_on 'Prato Teste'
   
   click_on 'Cadastrar Porção'
   fill_in 'Descrição', with: 'Porção Teste (600g)'
   fill_in 'Preço', with: 600
   click_on 'Cadastrar'

   click_on 'Cadastrar Porção'
   fill_in 'Descrição', with: 'Porção Teste (200g)'
   fill_in 'Preço', with: 200
   click_on 'Cadastrar'
   

   # Assert
   expect(page).to have_content "Cadastrado com sucesso"
   expect(page).to have_content "Porção Teste (600g)"
   expect(page).to have_content "Preço: R$ 6,00"

   expect(page).to have_content "Cadastrado com sucesso"
   expect(page).to have_content "Porção Teste (200g)"
   expect(page).to have_content "Preço: R$ 2,00"

  end

  it 'e tem acesso ao histórico de preço a partir da tela de detalhes' do
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

    dish = Dish.create!(
      name: 'Prato Teste',
      description: 'Uma descrição do prato de teste.',
      restaurant: restaurant
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Ver Restaurante"
    end

    click_on 'Prato Teste'
    
    click_on 'Cadastrar Porção'
    fill_in 'Descrição', with: 'Porção Teste (600g)'
    fill_in 'Preço', with: 600
    click_on 'Cadastrar'    

    # Assert
    
    expect(current_path).to eq restaurant_dish_path(restaurant.id, dish.id)
    
    expect(page).to have_content "Cadastrado com sucesso"
    expect(page).to have_content "Porção Teste (600g)"
    expect(page).to have_content "Preço: R$ 6,00"
  end

  it 'e não possui nenhuma porção cadastrada' do
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

    dish = Dish.create!(
      name: 'Prato Teste',
      description: 'Uma descrição do prato de teste.',
      restaurant: restaurant
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Ver Restaurante"
    end

    click_on 'Prato Teste'

    # Assert
    
    expect(current_path).to eq restaurant_dish_path(restaurant.id, dish.id)
    
    expect(page).to have_content "Não esqueça de adicionar porções para este prato!"
    
  end

  
end