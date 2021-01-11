if Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.storage    = :file
    config.enable_processing = false if Rails.env.test?
  end
else
  CarrierWave.configure do |config|
    config.storage    = :aws
    config.aws_bucket = ENV['BUCKET_NAME_PUBLIC']
    config.aws_acl    = 'private'

    # Set custom options such as cache control to leverage browser caching.
    # You can use either a static Hash or a Proc.
    config.aws_attributes = -> { {
      expires: 3.months.from_now.httpdate,
      cache_control: "max-age=#{90.days.to_i}"
    } }

    config.aws_credentials = {
      region: ENV['AWS_REGION'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID_PUBLIC'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY_PUBLIC']
    }
  end
end
