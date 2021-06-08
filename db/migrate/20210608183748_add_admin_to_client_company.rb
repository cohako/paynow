class AddAdminToClientCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :client_companies, :admin, :string
  end
end
