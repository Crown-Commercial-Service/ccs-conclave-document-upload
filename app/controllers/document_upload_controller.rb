include ActionController::HttpAuthentication::Basic::ControllerMethods
include ActionController::HttpAuthentication::Token::ControllerMethods

class DocumentUploadController < ApplicationController
  before_action :authenticate

  def create
    unchecked_document = @client.unchecked_documents.new(document_parameters.reject{|_, v| v.blank?})

    if unchecked_document.save
      send_check_request(unchecked_document.id)
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
      @client = Client.find_by_source_app(source_app)
      @client && @client.api_key == api_key
    end
  end

  def send_check_request(unchecked_document_id)
    return unless ENV['CHECK_ENDPOINT_URL']
    Rollbar.info("Checking document with id: #{unchecked_document_id}")

    HTTParty.put(ENV['CHECK_ENDPOINT_URL'], body:
      { unchecked_document_id: unchecked_document_id }, headers: {"Authorization" => ENV["AUTH_TOKEN"]})
  end

end
