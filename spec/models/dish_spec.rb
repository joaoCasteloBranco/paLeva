require 'rails_helper'

RSpec.describe Dish, type: :model do
  
  describe '#valid?' do
  it "é válido com nome, descrição e restaurante" do
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
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
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
    restaurant = Restaurant.new(
      registered_name: "Arvo",
      comercial_name: "Arvo Restaurante",
      cnpj: "61.236.299/0001-72",
      address: "Av. 1000",
      phone: "6731423872",
      email: "arvo@restaurante.com",
      user: user
    )
    dish = Dish.new(
      description: "Salada", calories: 150, restaurant: restaurant
    )
    expect(dish).to be_invalid
    expect(dish.errors[:name]).to include("não pode ficar em branco")
  end

  it "é inválido sem uma descrição" do
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
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
    expect(dish.errors[:description]).to include("não pode ficar em branco")
  end

  it "é invalido sem status" do
    user = User.create!(
    cpf: "109.789.030-99",
    email:  "sergio.vieira.de.melo@ri.com",
    name: "Sergio",
    last_name: "Vieira",
    password: "nacoesunidas",
    )
    restaurant = Restaurant.new(
    registered_name: "Arvo",
    comercial_name: "Arvo Restaurante",
    cnpj: "61.236.299/0001-72",
    address: "Av. 1000",
    phone: "6731423872",
    email: "arvo@restaurante.com",
    user: user
    )
    dish = Dish.new(
    name: "Salada César",
    calories: 150,
    restaurant: restaurant,
    status: nil
    )
    expect(dish).to be_invalid
    expect(dish.errors[:status]).to include("não pode ficar em branco")
  end

  it "é opcional ter calorias" do
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
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
    expect(dish.errors[:restaurant]).to include("não pode ficar em branco")
  end
  end
end
