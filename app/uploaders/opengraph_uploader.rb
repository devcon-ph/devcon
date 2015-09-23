# encoding: utf-8

class OpengraphUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.slug}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # disable until asset hosts work outside controllers
    ActionController::Base.helpers.asset_path([version_name, "default_thumbnail.png"].compact.join('_'))
  end

  # Create different versions of your uploaded files:
  version :opengraph do
    process :resize_and_pad => [1200, 630]
  end

  # Create different versions of your uploaded files:
  version :small do
    process :resize_and_pad => [600, 315]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
