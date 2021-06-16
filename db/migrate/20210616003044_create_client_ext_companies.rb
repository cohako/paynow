class CreateClientExtCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :client_ext_companies do |t|
      t.belongs_to :client_company, null: false, foreign_key: true
      t.belongs_to :client_external, null: false, foreign_key: true

      t.timestamps
    end
  end
end
