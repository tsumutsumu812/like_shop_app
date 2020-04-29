require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage :fog
  config.fog_provider = 'fog/aws'
  config.fog_directory  = 'new-you-like-backet'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 
    aws_secret_access_key: 
    region: 'ap-northeast-1',
    path_style: true
  }
end
