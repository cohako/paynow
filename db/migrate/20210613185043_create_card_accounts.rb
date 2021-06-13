class CreateCardAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :card_accounts do |t|
      t.integer :contract_number
      t.belongs_to :client_company, null: false, foreign_key: true
      t.belongs_to :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
