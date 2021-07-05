class Order < ApplicationRecord
  belongs_to :client_company
  belongs_to :client_product
  belongs_to :client_external

  has_one :receipt
  has_many :refused_histories

  before_create :generate_token
  after_create :set_due_date

  enum status: {pendente: 0, aprovada: 5, rejeitada: 10}
  enum payment_type: {boleto: 0, cartao: 1, pix: 2}

  validates :client_token, 
            :product_token, 
            :company_token,
            :payment_type, 
            :price, :price_discounted,
            presence: true

  validates :card_cvv, :print_name, 
            :card_number, presence: true, 
            if: :cartao?

  validates :boleto_address, 
            presence: true, 
            if: :boleto?

  validates :order_token, 
            uniqueness: true

  def generate_token
    self.order_token =  SecureRandom.base58(20)
    self.generate_token if Order.find_by(order_token: self.order_token)
  end

  def set_due_date
    self.due_date = 5.days.from_now
    self.save!
  end
end
