class CreateRefusedHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :refused_histories do |t|
      t.belongs_to :order, null: false, foreign_key: true
      t.integer :returned_code, default: 01
      t.date :attempt

      t.timestamps
    end
  end
end
