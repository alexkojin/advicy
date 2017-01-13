# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def size_range
    0..2.megabytes
  end

  def filename
     "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def store_dir
    'i'
  end

  protected
  def secure_token
    @secure_token ||= model.generate_token
  end
end
