# spec/models/restaurant_spec.rb
require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  let(:user) { User.create(email: "test@example.com", password: "password") }
  
  describe '#valid?' do
  
  it "is valid with valid attributes" do
    restaurant = Restaurant.new(
      user: user,
      registered_name: "Restaurante Teste Ltda",
      comercial_name: "Restaurante Teste",
      cnpj: "12.345.678/0001-95",
      address: "Rua Exemplo, 123",
      phone: "1122334455",
      email: "contato@restauranteteste.com",
      code: "R001"
    )
    expect(restaurant).to be_valid
  end

  it "false without a registered_name" do
    restaurant = Restaurant.new(
      user: user,
      registered_name: nil,
      comercial_name: "Restaurante Teste",
      cnpj: "12.345.678/0001-95",
      address: "Rua Exemplo, 123",
      phone: "1122334455",
      email: "contato@restauranteteste.com",
      code: "R001"
    )
    expect(restaurant).not_to be_valid
    expect(restaurant.errors[:registered_name]).to include("can't be blank")
  end

  it "false without a comercial_name" do
    restaurant = Restaurant.new(
      user: user,
      registered_name: "Restaurante Teste Ltda",
      comercial_name: nil,
      cnpj: "12.345.678/0001-95",
      address: "Rua Exemplo, 123",
      phone: "1122334455",
      email: "contato@restauranteteste.com",
      code: "R001"
    )
    expect(restaurant).not_to be_valid
    expect(restaurant.errors[:comercial_name]).to include("can't be blank")
  end

  it "false without a cnpj" do
    restaurant = Restaurant.new(
      user: user,
      registered_name: "Restaurante Teste Ltda",
      comercial_name: "Restaurante Teste",
      cnpj: nil,
      address: "Rua Exemplo, 123",
      phone: "1122334455",
      email: "contato@restauranteteste.com",
      code: "R001"
    )
    expect(restaurant).not_to be_valid
    expect(restaurant.errors[:cnpj]).to include("can't be blank")
  end

  it "false without an address" do
    restaurant = Restaurant.new(
      user: user,
      registered_name: "Restaurante Teste Ltda",
      comercial_name: "Restaurante Teste",
      cnpj: "12.345.678/0001-95",
      address: nil,
      phone: "1122334455",
      email: "contato@restauranteteste.com",
      code: "R001"
    )
    expect(restaurant).not_to be_valid
    expect(restaurant.errors[:address]).to include("can't be blank")
  end

  it "false without a phone" do
    restaurant = Restaurant.new(
      user: user,
      registered_name: "Restaurante Teste Ltda",
      comercial_name: "Restaurante Teste",
      cnpj: "12.345.678/0001-95",
      address: "Rua Exemplo, 123",
      phone: nil,
      email: "contato@restauranteteste.com",
      code: "R001"
    )
    expect(restaurant).not_to be_valid
    expect(restaurant.errors[:phone]).to include("can't be blank")
  end

  it "false without an email" do
    restaurant = Restaurant.new(
      user: user,
      registered_name: "Restaurante Teste Ltda",
      comercial_name: "Restaurante Teste",
      cnpj: "12.345.678/0001-95",
      address: "Rua Exemplo, 123",
      phone: "1122334455",
      email: nil,
      code: "R001"
    )
    expect(restaurant).not_to be_valid
    expect(restaurant.errors[:email]).to include("can't be blank")
  end


end





end
