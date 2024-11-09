class Order < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy
  has_many :servings, through: :order_items

  enum :status, {
    :awaiting_confirmation=>0, :in_preparation=>1, :canceled=>2, :ready=>3, :delivered=>4
  }, default: :awaiting_confirmation

  validates :status, :code, :customer_name, :contact_phone, presence: true
  validates :contact_phone, presence: true, unless: -> { contact_email.present? }
  validates :contact_email, presence: true, unless: -> { contact_phone.present? }
  validate :cpf_must_be_valid

  before_validation :generate_order_code

  def total_price
    BigDecimal(order_items.sum { |item| item.serving.price }) / 100
  end

  private

  def generate_order_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def cpf_must_be_valid
    errors.add(:cpf, 'inválido') unless CPF.valid?(cpf)
  end

end
