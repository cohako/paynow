class AddPaymentMethodToBoletoAccount < ActiveRecord::Migration[6.1]
  def change
    add_reference :boleto_accounts, :payment_method, null: false, foreign_key: true
  end
end
