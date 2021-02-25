unless Rails.env.test? || Rails.env.development?
    Sidekiq.configure_server do |config|
      config.redis = { url: JSON.parse(ENV['VCAP_SERVICES'])['redis'][0]['credentials']['uri'] }
    end
    Sidekiq.configure_client do |config|
      config.redis = { url: JSON.parse(ENV['VCAP_SERVICES'])['redis'][0]['credentials']['uri'] }
    end
  end