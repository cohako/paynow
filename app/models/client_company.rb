class ClientCompany < ApplicationRecord
  validates :cnpj, 
            :name, 
            :billing_address, 
            :billing_email, 
            presence: true 
            
  has_secure_token

  validates :cnpj, :token, uniqueness: true
  has_many :users
end
