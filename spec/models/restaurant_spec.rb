# spec/models/restaurant_spec.rb
require 'rails_helper'

RSpec.describe Restaurant, type: :model do 
  describe '#valid?' do
  
  it "is valid with valid attributes" do
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
    restaurant = Restaurant.new(
      user: user,
      registered_name: "Restaurante Teste Ltda",
      comercial_name: "Restaurante Teste",
      cnpj: "12.345.678/0001-95",
      address: "Rua Exemplo, 123",
      phone: "1122334455",
      email: "contato@restauranteteste.com",
    )
    expect(restaurant).to be_valid
  end

  it "false without a registered_name" do
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
    restaurant = Restaurant.new(
      user: user,
      registered_name: nil,
      comercial_name: "Restaurante Teste",
      cnpj: "12.345.678/0001-95",
      address: "Rua Exemplo, 123",
      phone: "1122334455",
      email: "contato@restauranteteste.com",
    )
    expect(restaurant).not_to be_valid
    expect(restaurant.errors[:registered_name]).to include("não pode ficar em branco")
  end

  it "false without a comercial_name" do
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
    restaurant = Restaurant.new(
      user: user,
      registered_name: "Restaurante Teste Ltda",
      comercial_name: nil,
      cnpj: "12.345.678/0001-95",
      address: "Rua Exemplo, 123",
      phone: "1122334455",
      email: "contato@restauranteteste.com",
    )
    expect(restaurant).not_to be_valid
    expect(restaurant.errors[:comercial_name]).to include("não pode ficar em branco")
  end

  it "false without a cnpj" do
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
    restaurant = Restaurant.new(
      user: user,
      registered_name: "Restaurante Teste Ltda",
      comercial_name: "Restaurante Teste",
      cnpj: nil,
      address: "Rua Exemplo, 123",
      phone: "1122334455",
      email: "contato@restauranteteste.com",
    )
    expect(restaurant).not_to be_valid
    expect(restaurant.errors[:cnpj]).to include("não pode ficar em branco")
  end

  it "false without an address" do
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
    restaurant = Restaurant.new(
      user: user,
      registered_name: "Restaurante Teste Ltda",
      comercial_name: "Restaurante Teste",
      cnpj: "12.345.678/0001-95",
      address: nil,
      phone: "1122334455",
      email: "contato@restauranteteste.com",
    )
    expect(restaurant).not_to be_valid
    expect(restaurant.errors[:address]).to include("não pode ficar em branco")
  end

  it "false without a phone" do
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
    restaurant = Restaurant.new(
      user: user,
      registered_name: "Restaurante Teste Ltda",
      comercial_name: "Restaurante Teste",
      cnpj: "12.345.678/0001-95",
      address: "Rua Exemplo, 123",
      phone: nil,
      email: "contato@restauranteteste.com",
    )
    expect(restaurant).not_to be_valid
    expect(restaurant.errors[:phone]).to include("não pode ficar em branco")
  end

  it "false without an email" do
    user = User.create!(
      cpf: "109.789.030-99",
      email:  "sergio.vieira.de.melo@ri.com",
      name: "Sergio",
      last_name: "Vieira",
      password: "nacoesunidas",
    )
    restaurant = Restaurant.new(
      user: user,
      registered_name: "Restaurante Teste Ltda",
      comercial_name: "Restaurante Teste",
      cnpj: "12.345.678/0001-95",
      address: "Rua Exemplo, 123",
      phone: "1122334455",
      email: nil,
    )
    expect(restaurant).not_to be_valid
    expect(restaurant.errors[:email]).to include("não pode ficar em branco")
  end


end





end
