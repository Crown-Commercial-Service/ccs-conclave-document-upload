class DocumentUploadController < ApplicationController
  include Authorize::ClientService
  rescue_from Authorize::ClientService::ApiError, with: :return_error_code
  before_action :validate_client_or_api_key
  before_action :find_client
  before_action :find_unchecked_document

  def create
    if @unchecked_document.save
      CallCheckServiceWorker.perform_async(@unchecked_document.id, @client.api_key, request.headers['Authorization'])
      document = camelize_keys(@unchecked_document.document)
      render json: document, status: :created
    else
      render json: @unchecked_document.errors, status: :unprocessable_entity
    end
  end

  private

  def document_parameters
    params.permit(:documentFile, :documentFilePath, :sourceApp, :sizeValidation,
                  typeValidation: []).transform_keys!(&:underscore)
  end

  def find_client
    @client = Client.find_by(api_key: request.headers['x-api-key'])
  end

  def find_unchecked_document
    @unchecked_document = @client.unchecked_documents.new(document_parameters.reject { |_, v| v.blank? })
  end

  def camelize_keys(document)
    document.as_json.deep_transform_keys! { |key| key.camelize(:lower) }
  end

  def return_error_code(code)
    render json: '', status: code.to_s
  end
end
