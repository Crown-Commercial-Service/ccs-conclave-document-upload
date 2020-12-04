class DocumentUploadController < ApplicationController

  def create
    document = Document.create(created_by: params[:service_name])
    UncheckedDocument.create(document_file: params[:file], document_file_path: params[:document_file_path], document: document)

    render json: document.to_json, status: :created
  end

  private

  def document_parameters
    params.permit(:file, :file_path, :service_name)
  end
end
