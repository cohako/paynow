class CreateBoletoAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :boleto_accounts do |t|
      t.integer :bank_code
      t.integer :agency_code
      t.integer :account_number
      t.belongs_to :client_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
