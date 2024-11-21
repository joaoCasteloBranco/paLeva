class Order < ApplicationRecord
  belongs_to :restaurant
  has_many :status_historics, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :servings, through: :order_items

  enum :status, {
    :awaiting_confirmation=>0, :in_preparation=>1, :canceled=>2, :ready=>3, :delivered=>4, :editing=>10
  }, default: :editing

  scope :active, -> { where.not(status: [:canceled, :delivered]) }

  validates :status, :code, :customer_name, presence: true
 
  validate :phone_or_email_present
  validate :cpf_must_be_valid

  before_validation :generate_order_code
  after_update :track_status_change

  def total_price
    BigDecimal(servings.sum { |serving| serving.price }) / 100
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

  def cancel_order(note)
    if canceled?
      errors.add(:status, "Already canceled")
      return false
    end
    Order.transaction do
      update!(status: :canceled) 
      StatusHistoric.create!(
        order: self,
        status: :canceled,
        changed_at: Time.current,
        notes: note
      )
    end
  end

  private

  def phone_or_email_present
    if contact_phone.blank? && contact_email.blank?
      errors.add(:base, 'Necessário um telefone ou email.')
    end
  end

  def generate_order_code
    self.code ||= SecureRandom.alphanumeric(8).upcase
  end

  def cpf_must_be_valid
    errors.add(:cpf, 'inválido') unless CPF.valid?(cpf)
  end

  def track_status_change
    return if status_previously_changed? && status == "canceled"
  
    if status_previously_changed?
      StatusHistoric.create!(
        order: self,
        status: status,
        changed_at: Time.current
      )
    end
  end

end
