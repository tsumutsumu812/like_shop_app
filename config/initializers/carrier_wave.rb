if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider              => 'AWS',
      :region                => ENV['ap-northeast-1'],     # 例: 'ap-northeast-1'
      :aws_access_key_id     => ENV['AKIA6Q2DN5TEVAQDSZPM'],
      :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['rails-uploader']
  end
end