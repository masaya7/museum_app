class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [200, 200]

  # Choose what kind of storage to use for this uploader:
  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    'sample.jpg'
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

# 投稿画像と額縁を合成
  def compose_images(frame_path, post_image_path, composed_image_path)
    frameq = MiniMagick::Image.open(frame_path)
    post_image = MiniMagick::Image.open(post_image_path)
    post_image.resize "#{frameq.width}x#{frameq.height}^"
    composed_image = frameq.composite(post_image) do |c|
      c.compose "Over"
    end
    composed_image.write(composed_image_path)
  end
end