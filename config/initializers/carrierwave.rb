if Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.storage    = :file
    config.enable_processing = false if Rails.env.test?
  end
else
  CarrierWave.configure do |config|
    config.storage    = :aws
    config.aws_bucket = JSON.parse(ENV['VCAP_SERVICES'])['aws-s3-bucket'][0]['credentials']['bucket_name']
    config.aws_acl    = 'private'

    config.aws_attributes = -> { {
      expires: 1.day.from_now.httpdate,
      cache_control: 'max-age=86400'
    } }

    config.aws_credentials = {
      region: JSON.parse(ENV['VCAP_SERVICES'])['aws-s3-bucket'][0]['credentials']['aws_region'],
      access_key_id: JSON.parse(ENV['VCAP_SERVICES'])['aws-s3-bucket'][0]['credentials']['aws_access_key_id'],
      secret_access_key: JSON.parse(ENV['VCAP_SERVICES'])['aws-s3-bucket'][0]['credentials']['aws_secret_access_key']
    }
  end
end
