def config_vault
  vcap_services = JSON.parse(ENV['VCAP_SERVICES'])
  key_store_path = ''
  key = vcap_services['hashicorp-vault'].first
  vault_engine = key['credentials']['backends_shared']['space']
  Vault.configure do |config|
    key_store_path = "#{vault_engine}/#{ENV['SERVER_ENV_NAME']}"
    config.address = key['credentials']['vault_addr']
    config.token = key['credentials']['vault_token']
    config.ssl_verify = false # only false until live is setup
  end
  set_env(key_store_path)
end

def set_env(storage_path)
  env_vars = Vault.logical.read(storage_path)
  env_vars.data.each do |env_key, env_value|
    ENV[env_key.to_s] = env_value.to_s
  end
end

config_vault if ENV['SERVER_ENV_NAME'].present?
