class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :restaurant

  validates :cpf, presence: true, uniqueness: true
  validate :unique_cpf_and_email_across_system

  enum :status, {:pre_registered=>0, :active=>1}

  def password_required?
    !pre_registered? || !new_record? && super
  end

  private

  def unique_cpf_and_email_across_system
    if User.exists?(cpf: cpf) || User.exists?(email: email)
      errors.add(:cpf, 'já está em uso por um usuário') if User.exists?(cpf: cpf)
      errors.add(:email, 'já está em uso por um usuário') if User.exists?(email: email)
    end
  end

end
