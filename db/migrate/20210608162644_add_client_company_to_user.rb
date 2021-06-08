class AddClientCompanyToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :client_company, foreign_key: true
  end
end
