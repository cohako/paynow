class AddPaymentIdToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :payment_id, :integer
  end
end
