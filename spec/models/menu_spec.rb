# spec/models/menu_spec.rb
require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe 'associations' do
    it 'pertence a um restaurant' do
      user = User.create!(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
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
      menu = Menu.new(name: "Almoço Executivo", restaurant: restaurant)

      expect(menu.restaurant).to eq(restaurant)
    end

    it 'tem muitos menu_items através de menu_contents' do
      user = User.create!(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
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
      menu = Menu.create!(name: "Almoço Executivo", restaurant: restaurant)

      dish = Dish.create!(
        name: "Cesar Salad",
        description: "Salada",
        calories: 150,
        restaurant: restaurant
      )
      menu_content = MenuContent.create!(menu: menu, menu_item: dish)

      expect(menu.menu_items).to include(dish)
    end
  end

  describe 'validations' do
    it 'é válido com um nome e um restaurant' do
      user = User.create!(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
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
      menu = Menu.new(name: "Almoço Executivo", restaurant: restaurant)

      expect(menu.valid?).to be true
    end

    it 'é inválido sem um nome' do
      restaurant = Restaurant.new
      menu = Menu.new(restaurant: restaurant)

      expect(menu.valid?).to be false
      expect(menu.errors[:name]).to include("não pode ficar em branco")
    end

    it 'é inválido com um nome duplicado para o mesmo restaurante' do
      user = User.create!(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
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
      Menu.create!(name: "Almoço Executivo", restaurant: restaurant)
      menu_duplicate = Menu.new(name: "Almoço Executivo", restaurant: restaurant)

      expect(menu_duplicate.valid?).to be false
      expect(menu_duplicate.errors[:name]).to include("Já existe um cardápio com esse nome")
    end

    it 'permite o mesmo nome para cardápios de restaurantes diferentes' do
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
      menu1 = Menu.create!(name: "Almoço Executivo", restaurant: restaurant_1)
      menu2 = Menu.new(name: "Almoço Executivo", restaurant: restaurant_2)

      expect(menu2.valid?).to be true
    end
  end
end
