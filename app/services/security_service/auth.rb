module SecurityService
  class Auth
    def initialize(client_id, access_token)
      @client_id = client_id
      @access_token = access_token
    end

    def sec_api_validate_token
      url = "/security/tokens/validation?client-id=#{@client_id}"

      resp = HTTParty.post(ENV['SECURITY_SERVICE_URL'] + url.to_s,
                           headers: { 'Content-Type' => 'application/x-www-form-urlencoded',
                                      'Authorization': "Bearer #{@access_token}" })

      api_status_error('Security Token Validation | method:sec_api_validate_token', resp)

      if resp.code == 200
        true if resp.body == 'true'
      else
        false
      end
    end

    def log_fatal(msg)
      Rails.logger.fatal msg
      Rollbar.critical msg
    end

    def api_status_error(msg, resp)
      log_fatal("#{msg} 403 ERROR #{resp.to_json}") if resp.code == 403
      log_fatal("#{msg} 401 ERROR #{resp.to_json}") if resp.code == 401
      log_fatal("#{msg} 429 ERROR Too Many Requests #{resp.to_json}") if resp.code == 429
    end
  end
end
