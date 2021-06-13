class ClientCompany < ApplicationRecord
  validates :cnpj, 
            :name, 
            :billing_address, 
            :billing_email, 
            presence: true 

  has_secure_token length: 20

  validates :cnpj, :token, uniqueness: true
  
  has_many :users
  has_many :boleto_accounts
  has_many :card_accounts
  has_many :payment_methods, through: :boleto_accounts
  has_many :payment_methods, through: :card_accounts
end
