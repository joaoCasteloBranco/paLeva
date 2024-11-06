class OperatingDay < ApplicationRecord
  belongs_to :restaurant
  validates :week_day, uniqueness: { scope: :restaurant_id, message: :already_set_day }
  validates :week_day, presence: true
  validates :opening_time, :closing_time, presence: true, if: :open?
  validates :closing_time, comparison: { greater_than: :opening_time }, if: :open?

  enum :week_day, {
    :sunday=>0, :monday=>1, :tuesday=>2, :wednesday=>3, :thursday=>4, :friday=>5, :saturday=>6
  }

end
