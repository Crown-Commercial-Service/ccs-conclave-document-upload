class CreateUncheckedDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :unchecked_documents, id: :uuid do |t|
      t.references :document, null: false, foreign_key: true, type: :uuid
      t.string :document_file, limit: 255

      t.timestamps
    end
  end
end
