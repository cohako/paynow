class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods do |t|
      t.string :name
      t.integer :payment_type
      t.decimal :payment_fee
      t.decimal :max_monetary_fee

      t.timestamps
    end
  end
end
