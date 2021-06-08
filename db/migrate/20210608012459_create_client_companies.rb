class CreateClientCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :client_companies do |t|
      t.integer :cnpj, null: false
      t.string :name, null: false
      t.text :billing_address, null: false
      t.string :billing_email, null: false
      t.string :token

      t.timestamps
    end
  end
end
