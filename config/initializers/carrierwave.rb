CarrierWave.configure do |config|
  # Configuration for Amazon S3 should be made available through an Environment variable.
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region:                ENV['AWS_S3_REGION']
  }

  config.fog_directory  = ENV['AWS_S3_BUCKET_NAME']
  config.fog_public     = true
  config.fog_use_ssl_for_aws = false

  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end
end
