class Order < ApplicationRecord
  belongs_to :client_company
  belongs_to :client_product
  belongs_to :client_external

  has_one :receipt
  has_many :refused_history

  after_create :generate_token
  after_create :set_due_date

  enum status: {pendente: 0, aprovada: 5, rejeitada: 10}
  enum payment_type: {boleto: 0, cartão: 1, pix: 2}

  validates :client_token, 
            :product_token, 
            :company_token,
            :payment_type, 
            :price, :price_discounted,
            :due_date,
            presence: true

  validates :card_cvv, :print_name, 
            :card_number, presence: true, 
            if: :cartão?

  validates :boleto_address, 
            presence: true, 
            if: :boleto?

  validates :order_token, 
            uniqueness: true

  def generate_token
      token =  SecureRandom.base58(20)
      colision = ClientProduct.where(product_token: token)
    if colision.empty?
      self.order_token = token
      self.save
    else
      self.generate_token
    end
  end

  def set_due_date
    self.due_date = 5.days.from_now
    self.save!
  end
end
