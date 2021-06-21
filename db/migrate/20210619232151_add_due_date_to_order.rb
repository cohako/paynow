class AddDueDateToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :due_date, :date
  end
end
