class Menu < ApplicationRecord
  belongs_to :restaurant
  has_many :menu_contents
  has_many :menu_items, through: :menu_contents

  validates :name, uniqueness: { scope: :restaurant_id, message: "Já existe um cardápio com esse nome" }
  validates :name, presence: true
  validate :validate_dates

  scope :active, -> { 
    where(
      "(start_date IS NULL AND end_date IS NULL) OR (start_date <= ? AND end_date >= ?)",
      Date.current, Date.current
    ) 
  }

  private

  def validate_dates
    if start_date.blank? && end_date.present?
      errors.add(:start_date, 'deve ser preenchida quando a data de fim está presente.')
    elsif start_date.present? && end_date.blank?
      errors.add(:end_date, 'deve ser preenchida quando a data de início está presente.')
    end
    if start_date.present? && end_date.present? && start_date > end_date
      errors.add(:end_date, 'deve ser posterior à data de início.')
    end
  end

end
