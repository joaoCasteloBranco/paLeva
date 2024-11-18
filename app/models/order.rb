class Order < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy
  has_many :servings, through: :order_items

  enum :status, {
    :awaiting_confirmation=>0, :in_preparation=>1, :canceled=>2, :ready=>3, :delivered=>4, :editing=>10
  }, default: :editing

  validates :status, :code, :customer_name, presence: true
 
  validate :phone_or_email_present
  validate :cpf_must_be_valid

  before_validation :generate_order_code

  def total_price
    BigDecimal(order_items.sum { |item| item.serving.price }) / 100
  end

  def can_transition_to?(new_status)
    case new_status
    when 'in_preparation'
      awaiting_confirmation?
    when 'ready'
      in_preparation?
    when 'delivered'
      ready?
    else
      true
    end
  end

  private

  def phone_or_email_present
    if contact_phone.blank? && contact_email.blank?
      errors.add(:base, 'Necessário um telefone ou email.')
    end
  end

  def generate_order_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def cpf_must_be_valid
    errors.add(:cpf, 'inválido') unless CPF.valid?(cpf)
  end

end
