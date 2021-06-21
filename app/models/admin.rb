class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :email_valid?
  
  def email_valid?
  user_domain = email.split('@')
    if user_domain[1] != 'paynow.com'
      self.errors.add(:email, "inválido")
    end
  end
end
