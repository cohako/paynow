class CreatePriceHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :price_histories do |t|
      t.belongs_to :client_product, null: false, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
