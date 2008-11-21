Paperclip.options[:image_magick_path] = '/opt/local/bin' if Rails.env.production?
Paperclip::Attachment.default_options[:default_url] = '/images/:attachment/:style/missing.jpg'
