class PaymentMethod < ApplicationRecord
  validates :name, :payment_fee, :max_monetary_fee, presence: true

  has_one_attached :icon

  enum payment_type: {boleto: 0, cartão: 1, pix: 2}
  enum status: {ativado: 0, desativado: 5}
end
