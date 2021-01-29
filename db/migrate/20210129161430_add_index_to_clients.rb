class AddIndexToClients < ActiveRecord::Migration[6.0]
  def change
    add_index :clients, :source_app, unique: true
    add_index :clients, :api_key, unique: true
  end
end
