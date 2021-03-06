class DocumentUploadController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate

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

  def authenticate
    authenticate_or_request_with_http_basic do |source_app, api_key|
      @client = Client.find_by(source_app: source_app)
      @client && @client.api_key == api_key
    end
  end
end
