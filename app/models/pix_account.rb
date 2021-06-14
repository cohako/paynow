class PixAccount < ApplicationRecord
  belongs_to :payment_method
  belongs_to :client_company

  validates_length_of :pix_code, maximum: 20

  validates :pix_code, presence: true

  validates :pix_code, uniqueness: true
end
