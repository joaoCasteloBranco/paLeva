class StatusHistoric < ApplicationRecord
  belongs_to :order

  validates :status, :changed_at, presence: true
end
