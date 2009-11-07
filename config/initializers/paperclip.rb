# convert and identify are installed in /opt/local both on my machine (via MacPorts) and in production.
# FIXME should remove this line before pushing to Heroku
Paperclip.options[:command_path] = '/opt/local/bin'

# S3 configuration!
if ENV['S3_BUCKET'] && !Rails.env.test?
  Paperclip::Attachment.default_options[:storage]    = :s3
  Paperclip::Attachment.default_options[:bucket]     = ENV['S3_BUCKET']
  Paperclip::Attachment.default_options[:url]        = ':s3_domain_url'
  Paperclip::Attachment.default_options[:path]       = '/:attachment/:id/:style/:filename'
  Paperclip::Attachment.default_options[:s3_headers] = { :cache_control => "public, max-age=#{10.years.to_i}" }

  Paperclip::Attachment.default_options[:s3_credentials] = {
    :access_key_id     => ENV['S3_KEY'],
    :secret_access_key => ENV['S3_SECRET']
  }
end
