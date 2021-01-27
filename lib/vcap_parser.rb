class VcapParser
  def self.load_service_environment_variables!
    return if ENV['VCAP_SERVICES'].blank?

    vcap_json = JSON.parse(ENV['VCAP_SERVICES'])
    vcap_json.fetch('user-provided', []).each do |service|
      service['credentials'].each_pair do |key, value|
        ENV[key] = value
      end
    end
  end
end