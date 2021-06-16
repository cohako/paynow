class CreateClientExternals < ActiveRecord::Migration[6.1]
  def change
    create_table :client_externals do |t|
      t.string :name
      t.integer :cpf
      t.string :client_external_token

      t.timestamps
    end
  end
end
