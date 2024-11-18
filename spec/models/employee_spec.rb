require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe '#valid?' do
    it 'é válido com cpf, email, status e restaurante associado' do
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
      employee = Employee.new(
        cpf: "333.222.111-00",
        email: "employee@example.com",
        status: :active,
        restaurant: restaurant,
        password: "nacoesunidas"
      )
      expect(employee).to be_valid
    end

    it 'é inválido sem um CPF' do
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
      employee = Employee.new(
        email: "employee@example.com",
        status: :active,
        restaurant: restaurant,
        password: "nacoesunidas"
      )
      expect(employee).not_to be_valid
      expect(employee.errors[:cpf]).to include("não pode ficar em branco")
    end

    it 'é inválido com um CPF duplicado' do
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
      Employee.create!(
        cpf: "333.222.111-00",
        email: "existing@example.com",
        status: :active,
        restaurant: restaurant,
        password: "nacoesunidas"
      )
      duplicate_employee = Employee.new(
        cpf: "333.222.111-00",
        email: "another@example.com",
        status: :pre_registered,
        restaurant: restaurant
      )
      expect(duplicate_employee).not_to be_valid
      expect(duplicate_employee.errors[:cpf]).to include("já está em uso")
    end

    it 'é inválido com email já usado por um usuário' do
      User.create!(
        name: "José",
        last_name: "Silva",
        cpf: "662.142.320-99",
        email: "email@email.com",
        password: "nacoesunidas"
      )
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
      employee = Employee.new(
        cpf: "333.222.111-00",
        email: "email@email.com",
        status: :active,
        restaurant: restaurant,
        password: "nacoesunidas"
      )
      expect(employee).not_to be_valid
      expect(employee.errors[:email]).to include("já está em uso por um usuário")
    end

    it 'é inválido sem um restaurante associado' do
      employee = Employee.new(
        cpf: "333.222.111-00",
        email: "employee@example.com",
        status: :active,
        password: "nacoesunidas"
      )
      expect(employee).not_to be_valid
      expect(employee.errors[:restaurant]).to include("é obrigatório(a)")
    end
  end
end
