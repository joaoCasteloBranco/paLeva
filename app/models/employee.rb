class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :restaurant

  validates :cpf, presence: true, uniqueness: true

  enum :status, {:pre_registered=>0, :active=>1}

  def password_required?
    !pre_registered? && super
  end
end
