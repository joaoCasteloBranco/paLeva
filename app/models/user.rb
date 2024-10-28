class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :restaurant, dependent: :destroy

  validates :name, :last_name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validate :cpf_must_be_valid

  private

  def cpf_must_be_valid
    errors.add(:cpf, 'inválido') unless CPF.valid?(cpf)
  end

end
