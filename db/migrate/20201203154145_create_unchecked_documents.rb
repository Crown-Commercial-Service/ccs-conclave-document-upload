class CreateUncheckedDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :unchecked_documents, id: :uuid do |t|
      t.references :document, null: false, foreign_key: true, type: :uuid

      t.datetime :created_at, default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
