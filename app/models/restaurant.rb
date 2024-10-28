class Restaurant < ApplicationRecord
  belongs_to :user

  validates :comercial_name, :registered_name, :cnpj, :address, :phone, :email, presence: true
  validates :phone, length: { in: 10..11 }
  validates :code, uniqueness: true
  validate :cnpj_must_be_valid

  before_create :generate_code


  private

  def cnpj_must_be_valid
    errors.add(:cnpj, "não é válido") unless CNPJ.valid?(cnpj)
  end

  def generate_unique_code
    loop do
      self.code = SecureRandom.alphanumeric(6).upcase
      break unless Restaurant.exists?(code: code)
    end
  end
end
