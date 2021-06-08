class ClientCompany < ApplicationRecord
  validates :cnpj, 
            :name, 
            :billing_address, 
            :billing_email, 
            presence: true 

  has_secure_token length: 20

  validates :cnpj, :token, uniqueness: true
  has_many :users
end
