CarrierWave.configure do |config|
  if Rails.env.production?
    config.asset_host = "http://assets.devcon.ph"
  end
end
