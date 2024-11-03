require 'rails_helper'

RSpec.describe Beverage, type: :model do
  

  describe '#valid?' do
    it "é válido com nome, descrição, marcador alcoólico e restaurante" do
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
    beverage = Beverage.new(name: "Cerveja", description: "Bebida refrescante", alcoholic: true, calories: 150, restaurant: restaurant)
    expect(beverage).to be_valid
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
    beverage = Beverage.new(description: "Bebida refrescante", alcoholic: true, calories: 150, restaurant: restaurant)
    expect(beverage).to be_invalid
    expect(beverage.errors[:name]).to include("não pode ficar em branco")
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
    beverage = Beverage.new(name: "Cerveja", alcoholic: true, calories: 150, restaurant: restaurant)
    expect(beverage).to be_invalid
    expect(beverage.errors[:description]).to include("não pode ficar em branco")
    end

    it "é inválido sem um marcador alcoólico" do
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
    beverage = Beverage.new(name: "Cerveja", description: "Bebida refrescante", calories: 150, restaurant: restaurant)
    expect(beverage).to be_invalid
    expect(beverage.errors[:alcoholic]).to include("não está incluído na lista")
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
    beverage = Beverage.new(name: "Cerveja", description: "Bebida refrescante", alcoholic: true, restaurant: restaurant)
    expect(beverage).to be_valid
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
    beverage = Beverage.new(
      name: "Cerveja",
      description: "Bebida refrescante",
      alcoholic: true,
      restaurant: restaurant,
      status: ''
      )
      expect(beverage).to be_invalid
      expect(beverage.errors[:status]).to include("não pode ficar em branco")
    end

    it "é inválido sem um restaurante associado" do
      
    beverage = Beverage.new(name: "Cerveja", description: "Bebida refrescante", alcoholic: true, calories: 150)
    expect(beverage).to be_invalid
    expect(beverage.errors[:restaurant]).to include("não pode ficar em branco")
    end
  end
end
