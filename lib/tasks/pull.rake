require 'shellwords'

namespace :pull do
  desc 'Clone production db and s3 data to staging'
  task :staging => 'pull:staging:db' do
    sh 'heroku rake pull:staging:s3 --remote staging'
  end

  namespace :staging do
    def dburl
      Shellwords.escape(`heroku pgbackups:url --remote production`.strip)
    end

    desc 'Clone production db to staging'
    task :db do
      sh "heroku pgbackups:capture --expire --remote production"
      sh "heroku pgbackups:restore #{dburl} --remote staging --confirm amanikids-staging"
    end

    desc 'Clone production s3 data to staging'
    task :s3 => :environment do
      AWS::S3::Base.establish_connection!(
        :access_key_id     => ENV['S3_KEY'],
        :secret_access_key => ENV['S3_SECRET']
      )

      source_bucket = 'amanikids'
      target_bucket = 'amanikids-staging'

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
end
