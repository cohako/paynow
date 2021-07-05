class Receipt < ApplicationRecord
  belongs_to :order
  has_one :client_company, through: :order
  has_one :client_product, through: :order

  before_create :generate_token

  validates :payment_date,
            :auth_code,
            presence: true


  def generate_token
    self.receipt_token =  SecureRandom.base58(20)
    self.generate_token if Receipt.find_by(receipt_token: self.receipt_token)
  end
end
