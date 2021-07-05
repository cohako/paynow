class ClientProduct < ApplicationRecord
  belongs_to :client_company

  has_many :price_histories, dependent: :destroy

  before_create :generate_token

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
    self.product_token =  SecureRandom.base58(20)
    self.generate_token if ClientProduct.find_by(product_token: self.product_token)
  end
end
