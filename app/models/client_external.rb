class ClientExternal < ApplicationRecord
  has_many :client_ext_companies
  has_many :client_companies, through: :client_ext_companies
end
