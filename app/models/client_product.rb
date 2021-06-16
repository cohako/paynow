class ClientProduct < ApplicationRecord
  belongs_to :client_company

  after_create :generate_token

  validates :name,
            :price, 
            :pix_discount,
            :card_discount,
            :boleto_discount,
            presence: true
  
  validates :product_token, 
            uniqueness: true
  
  
  def generate_token
      token =  SecureRandom.base58(20)
      colision = ClientProduct.where(product_token: token)
    if colision.empty?
      self.product_token = token
      self.save
    else
      self.generate_token
    end
  end
end
