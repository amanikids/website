namespace :s3 do
  desc 'Copy s3 production data to current environment.'
  task :pull => :environment do
    return if Rails.env.production?

    AWS::S3::Base.establish_connection!(
      :access_key_id     => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    )

    source_bucket = 'amanikids'
    target_bucket = ENV['S3_BUCKET']

    begin
      puts "[#{target_bucket}] FIND"
      AWS::S3::Bucket.find(target_bucket, :max_keys => 5)
    rescue AWS::S3::NoSuchBucket
      puts "[#{target_bucket}] CREATE"
      AWS::S3::Bucket.create(target_bucket, :access => :public_read)
    end

    require 'aws/s3/bucket_extensions'
    require 'aws/s3/object_extensions'

    AWS::S3::Bucket.find_each(source_bucket) do |object|
      object.copy_to_bucket(target_bucket, :access => :public_read)
    end
  end
end
