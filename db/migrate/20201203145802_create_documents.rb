class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents, id: :uuid  do |t|
      t.string :source_app, limit: 20
      t.string :state, limit: 20
      t.string :clamav_message, limit: 255
      t.string :document_file, limit: 255

      t.timestamps
    end
  end
end
