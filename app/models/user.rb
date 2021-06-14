class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :user_link

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
end
