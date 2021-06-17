class Order < ApplicationRecord
  belongs_to :client_company
  belongs_to :client_product
  belongs_to :client_external

  after_create :generate_token

  enum status: {pendente: 0, aprovada: 5, rejeitada: 10}
  enum payment_type: {boleto: 0, cartão: 1, pix: 2}

  validates :client_token, 
            :product_token, 
            :company_token,
            :payment_type, 
            :price, 
            presence: true


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
end
