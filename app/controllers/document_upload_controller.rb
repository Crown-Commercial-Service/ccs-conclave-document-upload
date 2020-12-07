class DocumentUploadController < ApplicationController

  def create
    unchecked_document = UncheckedDocument.new(document_parameters)
    if unchecked_document.save
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
