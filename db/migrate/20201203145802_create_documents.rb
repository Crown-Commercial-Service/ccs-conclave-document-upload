class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents, id: :uuid  do |t|
      t.string :created_by, limit: 20
      t.string :state, limit: 20
      t.string :clamav_message, limit: 255

      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
