require 'rails_helper'

RSpec.describe Marker, type: :model do
  describe 'associations' do
    it 'pertence a um restaurante' do
      user = User.new(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
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
      
      marker = Marker.new(name: "Apimentado", restaurant: restaurant)
      expect(marker.restaurant).to eq(restaurant)
    end

    it 'associaçõ menu_items' do
      user = User.new(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
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
      marker = Marker.create!(name: "Apimentado", restaurant: restaurant)
      dish = Dish.create!(
        name: "Cesar Salad",
        description: "Salada",
        calories: 150,
        restaurant: restaurant
      )
      MenuItemMarker.create!(marker: marker, menu_item: dish)

      expect(marker.menu_item).to include(dish)
    end
  end

  describe '#valid?' do
    it 'É valido com um nome e um restaurante' do
      user = User.new(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
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

      marker = Marker.new(name: "Apimentado", restaurant: restaurant)
      expect(marker.valid?).to be true
    end

    it 'é invalido sem um nome' do
      user = User.new(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas",
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

      marker = Marker.new(restaurant: restaurant)
      expect(marker.valid?).to be false
      expect(marker.errors[:name]).to include("não pode ficar em branco")
    end
  end
end
