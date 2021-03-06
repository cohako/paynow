class ClientCompany < ApplicationRecord
  validates :cnpj, 
            :name, 
            :billing_address, 
            :billing_email, 
            :domain,
            presence: true 
  
  after_create :generate_token
  after_save :set_user_admin

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

  has_many :orders
  
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

  def set_user_admin
    unless self.admin.nil?
      user = User.find(self.admin)
      user.admin!
      user.client_company_id = self.id
      user.save
    end
  end

end
