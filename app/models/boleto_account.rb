class BoletoAccount < ApplicationRecord
  belongs_to :client_company
  belongs_to :payment_method
end
