class CreatePixAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :pix_accounts do |t|
      t.string :pix_code
      t.belongs_to :payment_method, null: false, foreign_key: true
      t.belongs_to :client_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
