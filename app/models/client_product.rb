class ClientProduct < ApplicationRecord
  belongs_to :client_company

  has_secure_token :product_token, length: 20

end
