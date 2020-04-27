require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage :fog
  config.fog_provider = 'fog/aws'
  config.fog_directory  = 'new-you-like-backet'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIA6Q2DN5TEQA2ZGRSQ',
    aws_secret_access_key: '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',
    region: 'ap-northeast-1',
    path_style: true
  }
end
