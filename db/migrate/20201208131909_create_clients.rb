class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients, id: :uuid do |t|
      t.string :source_app, limit: 20
      t.string :api_key, limit: 255

      t.timestamps
    end
  end
end
