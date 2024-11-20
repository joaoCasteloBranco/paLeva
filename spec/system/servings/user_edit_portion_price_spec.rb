require 'rails_helper'

describe 'Usuário edita o preço de uma porção' do
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

    dish = Dish.create!(
      restaurant: restaurant, 
      name: "Prato Teste",
      description: 'Uma descrição do prato de teste.',
      calories: 300
    )

    serving = Serving.create!(
      menu_item: dish,
      price: 1000,
      description: 'Porção Teste (600g)'
    )

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on "Restaurante"
    end
    click_on "Prato Teste"
    click_on 'Atualizar Preço'
    fill_in 'Preço', with: 2000
    click_on 'Atualizar'
    click_on 'Atualizar Preço'
    fill_in 'Preço', with: 3000
    click_on 'Atualizar'
    

    # Assert
    expect(page).to have_content "Porção Teste (600g)"
    expect(page).to have_content "Preço Atual: R$ 30,00"
    expect(page).to have_content "Preço: R$ 20,00"
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

   beverage = Beverage.create!(
     restaurant: restaurant, 
     name: "Bebida Teste",
     description: 'Uma descrição do prato de teste.',
     calories: 300,
     alcoholic: false
     
   )

   serving = Serving.create!(
     menu_item: beverage,
     price: 1000,
     description: 'Porção Teste (600g)'
   )

   # Act
   login_as(user, :scope => :user)
   visit root_path
   within('nav') do
     click_on "Restaurante"
   end
   click_on "Bebida Teste"
   click_on 'Atualizar Preço'
   fill_in 'Preço', with: 2000
   click_on 'Atualizar'
   click_on 'Atualizar Preço'
   fill_in 'Preço', with: 3000
   click_on 'Atualizar'
   

   # Assert
   expect(page).to have_content "Porção Teste (600g)"
   expect(page).to have_content "Preço Atual: R$ 30,00"
   expect(page).to have_content "Preço: R$ 20,00"
   expect(page).to have_content "Preço: R$ 10,00"

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

  beverage = Beverage.create!(
    restaurant: restaurant, 
    name: "Bebida Teste",
    description: 'Uma descrição do prato de teste.',
    calories: 300,
    alcoholic: false
    
  )

  serving = Serving.create!(
    menu_item: beverage,
    price: 1000,
    description: 'Porção Teste (600g)'
  )

  # Act
  login_as(user, :scope => :user)
  visit root_path
  within('nav') do
    click_on "Restaurante"
  end
  click_on "Bebida Teste"
  click_on 'Atualizar Preço'
  fill_in 'Preço', with: 2000
  click_on 'Atualizar'
  click_on 'Atualizar Preço'
  fill_in 'Preço', with: nil
  click_on 'Atualizar'
  

  # Assert
  expect(page).to have_content "Não foi possível atualizar a porção"
  
  end
end