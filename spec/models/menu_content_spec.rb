require 'rails_helper'

RSpec.describe MenuContent, type: :model do
  describe 'associations' do
    it 'pertence a um menu' do
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
      
      menu = Menu.create!(name: "Café da Manhã", restaurant: restaurant)
      dish = Dish.create!(
        name: "Prato Teste",
        description: "Descrição",
        restaurant: restaurant,
      )

      menu_content = MenuContent.new(menu: menu, menu_item: dish)
      expect(menu_content.menu).to eq(menu)
    end

    it 'pertence a um menu_item' do
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

      menu = Menu.create!(name: "Café da Manhã", restaurant: restaurant)
      dish = Dish.create!(
        name: "Prato Teste",
        description: "Descrição",
        restaurant: restaurant,
      )

      menu_content = MenuContent.new(menu: menu, menu_item: dish)
      expect(menu_content.menu_item).to eq(dish)
    end
  end

  describe 'validations' do
    it 'é válido com um menu e um menu_item únicos' do
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

      menu = Menu.create!(name: "Café da Manhã", restaurant: restaurant)
      dish = Dish.create!(
        name: "Prato Teste",
        description: "Descrição",
        restaurant: restaurant,
      )

      menu_content = MenuContent.new(menu: menu, menu_item: dish)
      expect(menu_content.valid?).to be true
    end

    it 'é inválido com um menu_item duplicado no mesmo menu' do
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

      menu = Menu.create!(name: "Café da Manhã", restaurant: restaurant)
      
      dish = Dish.create!(
        name: "Prato Teste",
        description: "Descrição",
        restaurant: restaurant,
      )

      MenuContent.create!(menu: menu, menu_item: dish)

      menu_content_2 = MenuContent.new(menu: menu, menu_item: dish)

      expect(menu_content_2.valid?).to be false
      expect(menu_content_2.errors[:menu_id]).to include("Este item já está no cardápio.")
    end
  end
end
