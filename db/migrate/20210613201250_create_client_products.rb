class CreateClientProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :client_products do |t|
      t.string :name
      t.decimal :price
      t.decimal :pix_discount
      t.decimal :card_discount
      t.decimal :boleto_discount
      t.string :product_token
      t.belongs_to :client_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
