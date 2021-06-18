class ClientProduct < ApplicationRecord
  belongs_to :client_company

  has_many :price_histories

  after_create :generate_token

  after_save :price_update

  validates :name,
            :price, 
            :pix_discount,
            :card_discount,
            :boleto_discount,
            presence: true
  
  validates :product_token, 
            uniqueness: true

  has_many :orders
            
  def price_update
    if self.saved_change_to_price?
      PriceHistory.create!(client_product_id: self.id, price: self.price)
    end
  end

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
