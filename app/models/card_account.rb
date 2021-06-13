class CardAccount < ApplicationRecord
  belongs_to :client_company
  belongs_to :payment_method

  validates :contract_number, presence: true
  validates :contract_number, uniqueness: true
end
