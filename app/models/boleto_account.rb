class BoletoAccount < ApplicationRecord
  belongs_to :client_company
  belongs_to :payment_method

  validates :bank_code, 
            :agency_code, 
            :account_number, 
            :payment_method_id,
            presence: true

end
