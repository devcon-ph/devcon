# Use this hook to configure ckeditor
if Object.const_defined?("Ckeditor")
  Ckeditor.setup do |config|
    # ==> ORM configuration
    # Load and configure the ORM. Supports :active_record (default), :mongo_mapper and
    # :mongoid (bson_ext recommended) by default. Other ORMs may be
    # available as additional gems.
    require "ckeditor/orm/active_record"

    # Allowed image file types for upload.
    # Set to nil or [] (empty array) for all file types
    # config.image_file_types = ["jpg", "jpeg", "png", "gif", "tiff"]

    # Allowed attachment file types for upload.
    # Set to nil or [] (empty array) for all file types
    # config.attachment_file_types = ["doc", "docx", "xls", "odt", "ods", "pdf", "rar", "zip", "tar", "swf"]
    config.assets_languages = ['en']

    config.authorize_with :cancan
  end
  if Rails.env.test? or Rails.env.cucumber?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end
end
