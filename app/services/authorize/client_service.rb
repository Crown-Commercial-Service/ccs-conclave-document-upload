module Authorize
  module ClientService
    class ApiError < StandardError; end

    def validate_client_id
      decoded_token = validate_and_decode_token
      raise ApiError, 401 if decoded_token[0]['aud'].blank?
    end

    def validate_and_decode_token
      decoded_token = decode_token(request.headers)
      raise ApiError, 401 if decoded_token.blank?

      decoded_token
    end

    def validate_access_token
      decoded_token = validate_and_decode_token
      validate_token = SecurityService::Auth.new(decoded_token[0]['aud'],
                                                 bearer_token(request.headers)).sec_api_validate_token
      raise ApiError, 401 if validate_token.blank?
    end

    def bearer_token(request)
      pattern = /^Bearer /
      header  = request['Authorization']
      header.gsub(pattern, '') if header&.match(pattern)
    end

    def decode_token(request)
      bearer_token_from_header = bearer_token(request)
      JWT.decode bearer_token_from_header, nil, false if bearer_token_from_header.present?
    rescue StandardError
      {}
    end

    def api_key_to_string
      request.headers['x-api-key'].to_s if request.headers['x-api-key'].present?
    end

    def validate_api_key
      api_token = api_key_to_string
      return false if Client.find_by(api_key: api_token.to_s)&.id.blank?

      true
    end

    def validate_client_or_api_key
      return if validate_api_key

      validate_client_id
      validate_access_token
    end
  end
end
