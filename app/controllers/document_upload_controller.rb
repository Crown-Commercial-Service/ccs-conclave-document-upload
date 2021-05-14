class DocumentUploadController < ApplicationController
  def create
    unchecked_document = @client.unchecked_documents.new(document_parameters.reject { |_, v| v.blank? })

    if unchecked_document.save
      CallCheckServiceWorker.perform_async(unchecked_document.id)
      document = unchecked_document.document.as_json.deep_transform_keys! { |key| key.camelize(:lower) }
      render json: document, status: :created
    else
      render json: unchecked_document.errors, status: :unprocessable_entity
    end
  end

  private

  def document_parameters
    params.permit(:documentFile, :documentFilePath, :sourceApp, :sizeValidation,
                  typeValidation: []).transform_keys!(&:underscore)
  end
end
