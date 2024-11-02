class OperatingDay < ApplicationRecord
  belongs_to :restaurant
  validates :week_day, uniqueness: { scope: :restaurant_id, message: "already has a set schedule for that day of the week." }
  validates :week_day, presence: true

  enum :week_day, {
    :sunday=>0, :monday=>1, :tuesday=>2, :wednesday=>3, :thursday=>4, :friday=>5, :saturday=>6
  }


end
