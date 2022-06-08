class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include SecurityService::Auth
  before_action :api_key_or_access_token_auth

  private

  def authenticate
    request.headers['Authorization'] = request.headers['x-api-key']
    authenticate_or_request_with_http_basic do |source_app, api_key|
      @client = Client.find_by(source_app: source_app)
      @client && @client.api_key == api_key
    end
  end

  def api_key_or_access_token_auth
    return authenticate if request.headers['x-api-key'].present?

    validate_client_id
    validate_user_access_token
    validate_access_token
  end

  def validate_client_id
    decoded_token = validate_and_decode_token
    raise ActionController::BadRequest.new('Not authorized: Missing Client ID') if decoded_token[0]['aud'].blank?
  end

  def validate_user_access_token
    raise ActionController::BadRequest.new('Not authorized: Missing Access Token') if bearer_token(request.headers).blank?
  end

  def validate_access_token
    decoded_token = validate_and_decode_token
    validate_token = SecurityService::Auth.new(decoded_token[0]['aud'], bearer_token(request.headers)).sec_api_validate_token
    raise ActionController::BadRequest.new('Not authorized: Invalid Access Token') if validate_token.blank?
  end

  def validate_and_decode_token
    decoded_token = decode_token(request.headers)
    raise ActionController::BadRequest.new('Not authorized: Missing Access Token') if decoded_token.blank?
    decoded_token
  end

  def decode_token(request)
    bearer_token_from_header = bearer_token(request)
    JWT.decode bearer_token_from_header, nil, false if bearer_token_from_header.present?
  rescue StandardError
    {}
  end

  def bearer_token(request)
    pattern = /^Bearer /
    header  = request['Authorization']
    header.gsub(pattern, '') if header&.match(pattern)
  end
end
