class Discount < ApplicationRecord
  belongs_to :restaurant
  has_many :discount_servings
  has_many :servings, through: :discount_servings

  validates :name, :start_date, :end_date, :value, presence: true
  validates :value, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
  validates :limit_usage, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  validate :valid_date_range

  scope :active, -> { where("start_date <= ? AND end_date >= ?", Date.current, Date.current) }

  private

  def valid_date_range
    if start_date > end_date
      errors.add(:end_date, "deve ser posterior à data de início.")
    end
  end
end
