class CardAccount < ApplicationRecord
  belongs_to :client_company
  belongs_to :payment_method

  validates :contract_number, presence: true

  validates :contract_number, uniqueness: true

  validates_length_of :contract_number, maximum: 20
end
