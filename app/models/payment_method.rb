class PaymentMethod < ApplicationRecord
  validates :name, :payment_fee, :max_monetary_fee, presence: true

  has_one_attached :icon

  enum payment_type: {Boleto: 0, Cartão: 1, Pix: 2}
end
