class CreateReceipts < ActiveRecord::Migration[6.1]
  def change
    create_table :receipts do |t|
      t.date :payment_date
      t.string :auth_code
      t.belongs_to :order, null: false, foreign_key: true
      t.string :receipt_token

      t.timestamps
    end
  end
end
