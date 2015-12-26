require 'carrierwave/test/matchers'

describe CkeditorAttachmentFileUploader do
  include CarrierWave::Test::Matchers

  before do
    @file = Ckeditor::AttachmentFile.new
    CkeditorAttachmentFileUploader.enable_processing = true
    @uploader = CkeditorAttachmentFileUploader.new(@file, :data)

    File.open(File.join(Rails.root, "public/DevConFAQ.pdf")) do |f|
      @uploader.store!(f)
    end
  end

  after do
    CkeditorAttachmentFileUploader.enable_processing = false
    @uploader.remove!
  end

  it "should make the file readable only to all and not executable" do
    expect(@uploader).to have_permissions(0644)
  end


  it "should be the correct format" do
    expect(@uploader).to be_format('pdf')
  end
end
