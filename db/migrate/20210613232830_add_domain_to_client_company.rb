class AddDomainToClientCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :client_companies, :domain, :string
  end
end
