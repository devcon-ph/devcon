CarrierWave.configure do |config|
  if Rails.env.production?
    config.asset_host = "https://assets.devcon.ph"
  end
end
