require 'aws-sdk-ssm'

private

def config_aws
  params_list = []
  ssm_client = nil
  vcap_services = JSON.parse(ENV['VCAP_SERVICES'])

  vcap_services['user-provided'].each do |user_service|
    params_list = user_service['credentials']['VARS_LIST'] if user_service['credentials']['VARS_LIST'].present?
    next if user_service['credentials']['aws_access_key_id'].blank?

    ssm_client = Aws::SSM::Client.new(
      region: user_service['credentials']['region'],
      access_key_id: user_service['credentials']['aws_access_key_id'],
      secret_access_key: user_service['credentials']['aws_secret_access_key']
    )
  end
  set_env(ssm_client, params_list) if ssm_client && params_list
end

def set_env(ssm_client, params_list)
  params_list.split(/,/).each do |param_name|
    ENV[param_name] =
      ssm_client.get_parameter({ name: "/conclave-document-upload/#{param_name}",
                                 with_decryption: true })[:parameter][:value]
  end
end

config_aws if ENV['SERVER_ENV_NAME'].present?
