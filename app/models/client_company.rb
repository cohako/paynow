class ClientCompany < ApplicationRecord
  validates :cnpj, 
            :name, 
            :billing_address, 
            :billing_email, 
            :domain,
            presence: true 
  
  after_create :generate_token

  validates :cnpj, :token, uniqueness: true
  
  has_many :users

  has_many :boleto_accounts
  has_many :payment_methods, through: :boleto_accounts

  has_many :card_accounts
  has_many :payment_methods, through: :card_accounts

  has_many :pix_accounts
  has_many :payment_methods, through: :pix_accounts

  has_many :client_ext_companies
  has_many :client_externals, through: :client_ext_companies

  has_many :client_product
  
  def generate_token
      token =  SecureRandom.base58(20)
      colision = ClientCompany.where(token: token)
    if colision.empty?
      self.token = token
      self.save
    else
      self.generate_token
    end
  end

end
