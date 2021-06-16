class Order < ApplicationRecord
  belongs_to :client_company
  belongs_to :client_product
  belongs_to :client_external
end
