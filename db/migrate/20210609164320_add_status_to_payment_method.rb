class AddStatusToPaymentMethod < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_methods, :status, :integer, null: false, default: 0
  end
end
