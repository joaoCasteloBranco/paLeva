require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'é válido com todos os atributos presentes' do
      user = User.create!(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
      )
      restaurant = Restaurant.create!(
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com",
        user: user
      )
      order = Order.new(
        customer_name: "Carlos Silva",
        contact_phone: "61999999999",
        cpf: CPF.generate(true),
        status: :awaiting_confirmation,
        restaurant: restaurant
      )
      expect(order).to be_valid
    end

    it 'é inválido sem um nome de cliente' do
      user = User.create!(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
      )
      restaurant = Restaurant.create!(
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com",
        user: user
      )
      order = Order.new(
        contact_phone: "61999999999",
        cpf: CPF.generate(true),
        status: :awaiting_confirmation,
        restaurant: restaurant
      )
      expect(order).not_to be_valid
      expect(order.errors[:customer_name]).to include("não pode ficar em branco")
    end

    it 'é inválido sem telefone ou email de contato' do
      user = User.create!(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
      )
      restaurant = Restaurant.create!(
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com",
        user: user
      )
      order = Order.new(
        customer_name: "Carlos Silva",
        cpf: CPF.generate(true),
        status: :awaiting_confirmation,
        restaurant: restaurant
      )
      expect(order).not_to be_valid
      expect(order.errors[:base]).to include("Necessário um telefone ou email.")
    end

    it 'é inválido com CPF inválido' do
      user = User.create!(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
      )
      restaurant = Restaurant.create!(
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com",
        user: user
      )
      order = Order.new(
        customer_name: "Carlos Silva",
        contact_phone: "61999999999",
        cpf: "123.456.789-00",
        status: :awaiting_confirmation,
        restaurant: restaurant
      )
      expect(order).not_to be_valid
      expect(order.errors[:cpf]).to include("inválido")
    end

    it 'gera um código automaticamente antes da validação' do
      user = User.create!(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
      )
      restaurant = Restaurant.create!(
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com",
        user: user
      )
      order = Order.new(
        customer_name: "Carlos Silva",
        contact_phone: "61999999999",
        cpf: CPF.generate(true),
        status: :awaiting_confirmation,
        restaurant: restaurant
      )
      expect(order.code).to be_nil
      order.valid?
      expect(order.code).not_to be_nil
      expect(order.code).to match(/\A[A-Z0-9]{8}\z/)
    end

    it 'é inválido sem restaurante associado' do
      order = Order.new(
        customer_name: "Carlos Silva",
        contact_phone: "61999999999",
        cpf: CPF.generate(true),
        status: :awaiting_confirmation
      )
      expect(order).not_to be_valid
      expect(order.errors[:restaurant]).to include("é obrigatório(a)")
    end
  end

  describe '#total_price' do
    it 'retorna o preço total dos itens do pedido' do
      user = User.create!(
        cpf: "109.789.030-99",
        email: "sergio.vieira.de.melo@ri.com",
        name: "Sergio",
        last_name: "Vieira",
        password: "nacoesunidas"
      )
      restaurant = Restaurant.create!(
        registered_name: "Arvo",
        comercial_name: "Arvo Restaurante",
        cnpj: "61.236.299/0001-72",
        address: "Av. 1000",
        phone: "6731423872",
        email: "arvo@restaurante.com",
        user: user
      )

      dish = Dish.create!(
        name: "Cesar Salad",
        description: "Salada",
        calories: 150,
        restaurant: restaurant
      )

      serving_1 = Serving.create!(price: 2000, description: "Porção Média 600g", menu_item: dish)
      serving_2 = Serving.create!(price: 500, description: "Porção Média 600g", menu_item: dish)
      order = Order.create!(
        customer_name: "Carlos Silva",
        contact_phone: "61999999999",
        cpf: CPF.generate(true),
        status: :awaiting_confirmation,
        restaurant: restaurant
      )
      order.order_items.create!(serving: serving_1)
      order.order_items.create!(serving: serving_2)

      expect(order.total_price).to eq(25.00)
    end
  end
end
