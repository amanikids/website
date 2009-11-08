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
