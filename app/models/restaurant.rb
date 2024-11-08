class Restaurant < ApplicationRecord
  belongs_to :user
  
  has_many :menu_items
  has_many :dishes, dependent: :destroy
  has_many :beverages, dependent: :destroy

  has_many :operating_days
  
  has_many :markers
  has_many :menus

  validates :comercial_name, :registered_name, :cnpj, :address, :phone, :email, presence: true
  validates :phone, length: { in: 10..11 }
  validates :user, :code, :registered_name, :cnpj, uniqueness: true
  validate :cnpj_must_be_valid

  before_create :generate_unique_code

  after_destroy :remove_user_association

  def all_operating_days_added?
    operating_days.length < 7
  end

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

  def remove_user_association
    user.update(restaurant: nil)
  end
end
