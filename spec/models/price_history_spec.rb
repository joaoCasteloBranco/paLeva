require 'rails_helper'

RSpec.describe PriceHistory, type: :model do
  describe 'validations' do
    it 'é válido com um preço e um serving' do
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
      dish = Dish.create!(
        name: "Cesar Salad",
        description: "Salada",
        calories: 150,
        restaurant: restaurant
      )
      serving = Serving.create!(
        menu_item: dish,
        description: "Porção Média, 600g",
        price: 1000
      )
 
      expect(serving.price_histories.first.valid?).to be true
    end

    it 'é inválido sem um preço' do
      price_history = PriceHistory.new
      expect(price_history.valid?).to be false
      expect(price_history.errors[:price]).to include("não pode ficar em branco")
    end

    it 'é inválido com preço negativo' do
      price_history = PriceHistory.new(price: -500)
      expect(price_history.valid?).to be false
      expect(price_history.errors[:price]).to include("deve ser maior ou igual a 0")
    end
  end

  describe '#price_display' do
    it 'retorna o preço formatado em reais' do
      price_history = PriceHistory.new(price: 12345)
      expect(price_history.price_display).to eq(BigDecimal("123.45"))
    end
  end
end
