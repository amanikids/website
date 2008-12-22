# convert and identify are installed in /opt/local both on my machine (via MacPorts) and in production.
Paperclip.options[:image_magick_path] = '/opt/local/bin'

# missing attachments have a default image here:
Paperclip::Attachment.default_options[:default_url] = '/images/:attachment/:style/missing.jpg'
