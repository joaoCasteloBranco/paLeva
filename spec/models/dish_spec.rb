require 'rails_helper'

RSpec.describe Dish, type: :model do
  let(:user) { User.create(email: "test@example.com", password: "password") }
  describe '#valid?' do
  it "é válido com nome, descrição e restaurante" do
    restaurant = Restaurant.new(
      registered_name: "Arvo",
      comercial_name: "Arvo Restaurante",
      cnpj: "61.236.299/0001-72",
      address: "Av. 1000",
      phone: "6731423872",
      email: "arvo@restaurante.com",
      user: user
    )
    dish = Dish.new(name: "Salada César", description: "Salada", calories: 150, restaurant: restaurant)
    expect(dish).to be_valid
  end

  it "é inválido sem um nome" do
    restaurant = Restaurant.new(
      registered_name: "Arvo",
      comercial_name: "Arvo Restaurante",
      cnpj: "61.236.299/0001-72",
      address: "Av. 1000",
      phone: "6731423872",
      email: "arvo@restaurante.com",
      user: user
    )
    dish = Dish.new(description: "Salada", calories: 150, restaurant: restaurant)
    expect(dish).to be_invalid
    expect(dish.errors[:name]).to include("can't be blank")
  end

  it "é inválido sem uma descrição" do
    restaurant = Restaurant.new(
      registered_name: "Arvo",
      comercial_name: "Arvo Restaurante",
      cnpj: "61.236.299/0001-72",
      address: "Av. 1000",
      phone: "6731423872",
      email: "arvo@restaurante.com",
      user: user
    )
    dish = Dish.new(name: "Salada César", calories: 150, restaurant: restaurant)
    expect(dish).to be_invalid
    expect(dish.errors[:description]).to include("can't be blank")
  end

  it "é opcional ter calorias" do
    restaurant = Restaurant.new(
      registered_name: "Arvo",
      comercial_name: "Arvo Restaurante",
      cnpj: "61.236.299/0001-72",
      address: "Av. 1000",
      phone: "6731423872",
      email: "arvo@restaurante.com",
      user: user
    )
    dish = Dish.new(name: "Salada César", description: "Salada", restaurant: restaurant)
    expect(dish).to be_valid
  end

  it "é inválido sem um restaurante associado" do
    dish = Dish.new(name: "Salada César", description: "Salada com alface", calories: 150)
    expect(dish).to be_invalid
    expect(dish.errors[:restaurant]).to include("must exist")
  end
  end
end
