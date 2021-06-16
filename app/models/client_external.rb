class ClientExternal < ApplicationRecord
  has_many :client_ext_companies
  has_many :client_companies, through: :client_ext_companies
  after_create :generate_token

  validates :name, :cpf, presence: true
  validates :cpf, :client_external_token, uniqueness: true

  validates :cpf, length: {is: 11}


  def generate_token
    token =  SecureRandom.base58(20)
    colision = ClientCompany.where(token: token)
    if colision.empty?
      self.client_external_token = token
      self.save
    else
      self.generate_token
    end
  end
end
