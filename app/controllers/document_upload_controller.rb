class DocumentUploadController < ApplicationController
  def create
    unchecked_document = @client.unchecked_documents.new(document_parameters.reject { |_, v| v.blank? })

    if unchecked_document.save
      CallCheckServiceWorker.perform_async(unchecked_document.id)
      render json: unchecked_document.document.to_json, status: :created
    else
      render json: unchecked_document.errors, status: :unprocessable_entity
    end
  end

  private

  def document_parameters
    params.permit(:document_file, :document_file_path, :source_app, :size_validation, type_validation: [])
  end
end
