class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :client_company, null: false, foreign_key: true
      t.belongs_to :client_product, null: false, foreign_key: true
      t.belongs_to :client_external, null: false, foreign_key: true
      t.decimal :price
      t.decimal :price_discounted
      t.integer :payment_type
      t.integer :card_number
      t.string :print_name
      t.integer :card_cvv
      t.string :boleto_address
      t.integer :status, default: 0, null: false
      t.string :company_token
      t.string :product_token
      t.string :client_token
      t.string :order_token

      t.timestamps
    end
  end
end
