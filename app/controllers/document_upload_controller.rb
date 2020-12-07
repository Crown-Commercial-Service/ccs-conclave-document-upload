class DocumentUploadController < ApplicationController

  def create
    document = Document.new(created_by: document_parameters[:service_name])
    unchecked_document = UncheckedDocument.new(document_parameters.merge(document: document))
    if unchecked_document.valid?
      document.save && unchecked_document.save
      render json: document.to_json, status: :created
    else
      render json: unchecked_document.errors, status: :unprocessable_entity
    end
  end

  private

  def document_parameters
    params.permit(:document_file, :document_file_path, :service_name, :size_validation, type_validation: [])
  end
end
