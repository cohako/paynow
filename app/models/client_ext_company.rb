class ClientExtCompany < ApplicationRecord
  belongs_to :client_company
  belongs_to :client_external
end
