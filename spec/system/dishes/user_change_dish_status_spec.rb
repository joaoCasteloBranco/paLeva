require 'rails_helper'

describe 'Usuário muda status de um prato' do
  it 'e ativa com sucesso depois de desativar' do
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
    click_on 'Desativar Prato'
    click_on 'Prato Teste'
    click_on 'Ativar Prato'

    # Assert
    expect(page).to have_content "Ativo"
    expect(page).not_to have_content "Inativo"
    expect(page).to have_content "Prato Teste agora está ativo"

  end

  it 'e desativa com sucesso' do
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
   click_on 'Desativar Prato'

   # Assert
   expect(page).to have_content "Inativo"
   expect(page).not_to have_content "Ativo"
   expect(page).to have_content "Prato Teste agora está inativo"
 end

 it 'e está ativo por padrão' do
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

 # Assert
 expect(page).not_to have_content "Inativo"
 expect(page).to have_content "Ativo"

end
end