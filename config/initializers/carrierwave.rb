CarrierWave.configure do |config|

  if Rails.env.production? || Rails.env.development?
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['S3_ACCESS_KEY_ID'],      # required
      :aws_secret_access_key  => ENV['SECRET_KEY'],            # required
      :region                 => 'us-west-2'
    }
    config.fog_directory  = ENV['S3_BUCKET']                   # required
  end
end
