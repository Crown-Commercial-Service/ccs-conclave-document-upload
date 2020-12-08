class AddClientReferenceToUncheckedDocuments < ActiveRecord::Migration[6.0]
  def change
    add_reference :unchecked_documents, :client, null: false, foreign_key: true, type: :uuid
  end
end
