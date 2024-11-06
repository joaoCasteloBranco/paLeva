require 'rails_helper'

RSpec.describe Serving, type: :model do
  describe 'associations' do
    it 'pertence a um menu_item' do
      user = User.new(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
      )
      restaurant = Restaurant.new(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
      dish = Dish.new(
        name: "Cesar Salad",
        description: "Salada",
        calories: 150,
        restaurant: restaurant
      )
      serving = Serving.new(price: 1000, description: "Porção Média 600g", menu_item: dish)
      
      expect(serving.menu_item).to eq(dish)
    end

    it 'tem muitos price_histories' do
      user = User.new(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
      )
      restaurant = Restaurant.new(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
      dish = Dish.create!(
        name: "Cesar Salad",
        description: "Salada",
        calories: 150,
        restaurant: restaurant
      )
      serving = Serving.create!(price: 1000, description: "Porção Média 600g", menu_item: dish)
      serving.update(price: 2000)

      expect(serving.price_histories.count).to eq 2
    end
  end

  describe 'validations' do
    it 'é válido com descrição, preço e menu_item_id' do
      user = User.new(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
      )
      restaurant = Restaurant.new(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
      dish = Dish.create!(
        name: "Cesar Salad",
        description: "Salada",
        calories: 150,
        restaurant: restaurant
      )
      serving = Serving.create!(price: 1000, description: "Porção Média 600g", menu_item: dish)

      expect(serving.valid?).to be true
    end

    it 'é inválido sem descrição' do
      user = User.new(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
      )
      restaurant = Restaurant.new(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
      dish = Dish.new(
        name: "Cesar Salad",
        description: "Salada",
        calories: 150,
        restaurant: restaurant
      )
      serving = Serving.new(price: 1000, menu_item: dish)
      expect(serving.valid?).to be false
      expect(serving.errors[:description]).to include("não pode ficar em branco")
    end

    it 'é inválido sem preço' do
      user = User.new(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
      )
      restaurant = Restaurant.new(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
      dish = Dish.new(
        name: "Cesar Salad",
        description: "Salada",
        calories: 150,
        restaurant: restaurant
      )
      serving = Serving.new(description: "Porção Média 600g", menu_item: dish)
      expect(serving.valid?).to be false
      expect(serving.errors[:price]).to include("não pode ficar em branco")
    end

    it 'é inválido sem menu_item_id' do
      serving = Serving.new(description: "Porção Média 600g", price: 1000)
      expect(serving.valid?).to be false
      expect(serving.errors[:menu_item_id]).to include("não pode ficar em branco")
    end
  end

  describe '#price_display' do
    it 'retorna o preço formatado em reais' do
      user = User.new(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
      )
      restaurant = Restaurant.new(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
      dish = Dish.new(
        name: "Cesar Salad",
        description: "Salada",
        calories: 150,
        restaurant: restaurant
      )
      serving = Serving.new(price: 12345, description: "Porção Média 600g", menu_item: dish)
      expect(serving.price_display).to eq(BigDecimal("123.45"))
    end
  end

  describe 'callbacks' do
    it 'cria um price_history após a criação de um serving' do
      user = User.new(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
      )
      restaurant = Restaurant.new(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
      dish = Dish.create!(
        name: "Cesar Salad",
        description: "Salada",
        calories: 150,
        restaurant: restaurant
      )
      serving = Serving.create!(price: 1000, description: "Porção Média 600g", menu_item: dish)

      expect(serving.price_histories.count).to eq(1)
      expect(serving.price_histories.first.price).to eq(1000)
    end

    it 'cria um price_history após a atualização de um serving' do
      user = User.new(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
      )
      restaurant = Restaurant.new(
        user: user,
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com"
      )
      dish = Dish.create!(
        name: "Cesar Salad",
        description: "Salada",
        calories: 150,
        restaurant: restaurant
      )
      serving = Serving.create!(price: 1000, description: "Porção Média 600g", menu_item: dish)
      serving.update(price: 1200)

      expect(serving.price_histories.count).to eq(2)
      expect(serving.price_histories.last.price).to eq(1200)
    end
  end
end
