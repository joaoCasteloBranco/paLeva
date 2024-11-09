class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :serving

  validates :serving, presence: true
end