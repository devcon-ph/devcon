require 'carrierwave/test/matchers'

describe CkeditorPictureUploader do
  include CarrierWave::Test::Matchers

  before do
    @picture = Ckeditor::Picture.new
    CkeditorPictureUploader.enable_processing = true
    @uploader = CkeditorPictureUploader.new(@picture, :data)

    File.open(File.join(Rails.root, "app/assets/images/logo.png")) do |f|
      @uploader.store!(f)
    end
  end

  after do
    CkeditorPictureUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the thumb version' do
    it "should scale down a landscape image to be exactly 64 by 64 pixels" do
      expect(@uploader.thumb).to have_dimensions(118, 100)
    end
  end

  it "should make the image readable only to all and not executable" do
    expect(@uploader).to have_permissions(0644)
  end

  it "should be the correct format" do
    expect(@uploader).to be_format('png')
  end
end
