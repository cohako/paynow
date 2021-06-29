class Receipt < ApplicationRecord
  belongs_to :order
  has_one :client_company, through: :order
  has_one :client_product, through: :order

  after_create :generate_token

  validates :payment_date,
            :auth_code,
            presence: true


  def generate_token
      token =  SecureRandom.base58(20)
      colision = ClientProduct.where(product_token: token)
    if colision.empty?
      self.receipt_token = token
      self.save
    else
      self.generate_token
    end
  end
end
