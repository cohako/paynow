class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :user_link
  before_validation :email_valid?

  validates :roles, presence: true

  enum roles: {service: 0, admin: 5}

  belongs_to :client_company, optional: true

  def user_link
    user_domain = email.split('@')
    if client_company = ClientCompany.find_by(domain: user_domain[1])
      self.client_company_id = client_company.id
      self.save!
    end
  end
  
  def email_valid?
    deny_list = File.read(Rails.root.join('lib/assets/txt/email_deny.txt')).split
    user_domain = email.split('@')
    if deny_list.include?(user_domain[1])
      self.errors.add(:email, "inválido")
    end
  end
end
