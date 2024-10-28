require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:valid_cpf) { '109.789.030-99' } 
  let(:invalid_cpf) { '123.456.789-00' } 

  describe '#valid?' do
    it 'is valid' do
      user = User.new(name: 'João', last_name: 'Silva', cpf: valid_cpf, email: 'joao@example.com', password: 'nacoesunidas')
      expect(user).to be_valid
    end

    it 'false without a name' do
      user = User.new(last_name: 'Silva', cpf: valid_cpf, email: 'joao@example.com', password: 'nacoesunidas')
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'false without a last_name' do
      user = User.new(name: 'João', cpf: valid_cpf, email: 'joao@example.com', password: 'nacoesunidas')
      expect(user).not_to be_valid
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it 'false without a cpf' do
      user = User.new(name: 'João', last_name: 'Silva', email: 'joao@example.com', password: 'nacoesunidas')
      expect(user).not_to be_valid
      expect(user.errors[:cpf]).to include("can't be blank")
    end

    it 'false with an invalid cpf' do
      user = User.new(name: 'João', last_name: 'Silva', cpf: invalid_cpf, email: 'joao@example.com', password: 'nacoesunidas')
      expect(user).not_to be_valid
      expect(user.errors[:cpf]).to include('inválido')
    end

    it 'false with a duplicate cpf' do
      User.create(name: 'Maria', last_name: 'Santos', cpf: valid_cpf, email: 'maria@example.com', password: 'outrasenhas123')
      user = User.new(name: 'João', last_name: 'Silva', cpf: valid_cpf, email: 'joao@example.com', password: 'nacoesunidas')
      expect(user).not_to be_valid
      expect(user.errors[:cpf]).to include('has already been taken')
    end

    it 'is not valid with a password shorter than 12 characters' do
      user = User.new(name: 'João', last_name: 'Silva', cpf: valid_cpf, email: 'joao@example.com', password: 'curta')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('is too short (minimum is 12 characters)')
    end
  end
end
