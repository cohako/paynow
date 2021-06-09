class PaymentMethod < ApplicationRecord
  validates :name, :payment_fee, :max_monetary_fee, presence: true

  has_one_attached :icon

  enum payment_type: {Boleto: 0, Cartão: 1, Pix: 2}
  enum status: {Ativado: 0, Desativado: 5}
end
