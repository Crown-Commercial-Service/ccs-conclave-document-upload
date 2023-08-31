require 'jwt'
require 'net/http'

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate

  private

  def authenticate
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last if auth_header

    if !token.nil?
      begin
        decoded_token = JWT.decode(token, nil, false)
        aud = decoded_token[0]['aud']
        uri = URI.parse('https://dev.ppg-sso-service.crowncommercial.gov.uk/security/tokens/validation?client-id=`')

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request = Net::HTTP::Post.new(uri.path)
        request.body = "aud=#{aud}"
        response = http.request(request)
        response.code == '200'

      rescue JWT::DecodeError
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    else
      request.headers['Authorization'] = request.headers['x-api-key']
      authenticate_or_request_with_http_basic do |source_app, api_key|
        @client = Client.find_by(source_app: source_app)
        @client && @client.api_key == api_key
      end  
    end
  end
end


