require 'rails_helper'

RSpec.describe OperatingDay, type: :model do
  describe 'associations' do
    it 'pertence a um restaurante' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
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

      operating_day = OperatingDay.new(week_day: :monday, restaurant: restaurant)
      expect(operating_day.restaurant).to eq(restaurant)
    end
  end

  describe 'validations' do
    it 'é válido com week_day, opening_time e closing_time quando marcado como aberto' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
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
      operating_day = OperatingDay.new(
        week_day: :monday,
        opening_time: "09:00",
        closing_time: "18:00",
        restaurant: restaurant
      )
      expect(operating_day.valid?).to be true
    end

    it 'é inválido sem week_day' do
      operating_day = OperatingDay.new(opening_time: "09:00", closing_time: "18:00")
      expect(operating_day.valid?).to be false
      expect(operating_day.errors[:week_day]).to include("não pode ficar em branco")
    end

    it 'é inválido sem opening_time e closing_time se marcado como aberto' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
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
      operating_day = OperatingDay.new(week_day: :monday, restaurant: restaurant, open: true)
      expect(operating_day.valid?).to be false
      expect(operating_day.errors[:opening_time]).to include("não pode ficar em branco")
      expect(operating_day.errors[:closing_time]).to include("não pode ficar em branco")
    end

    it 'é inválido se já houver um horário definido para o mesmo dia da semana no mesmo restaurante' do
      user = User.create!(
        cpf: "109.789.030-99",
        email:  "sergio.vieira.de.melo@ri.com",
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
      OperatingDay.create!(
        week_day: :monday,
        opening_time: "09:00",
        closing_time: "18:00",
        restaurant: restaurant
      )
      duplicate_operating_day = OperatingDay.new(
        week_day: :monday,
        opening_time: "10:00",
        closing_time: "20:00",
        restaurant: restaurant
      )
      expect(duplicate_operating_day.valid?).to be false
      expect(duplicate_operating_day.errors[:week_day]).to include("already has a set schedule for that day of the week.")
    end
  end
end
