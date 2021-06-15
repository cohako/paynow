class ClientProduct < ApplicationRecord
  belongs_to :client_company

  has_secure_token :product_token, length: 20

  validates :name,
            :price, 
            :pix_discount,
            :card_discount,
            :boleto_discount,
            presence: true

  validates :product_token, 
            uniqueness: true

  
end
