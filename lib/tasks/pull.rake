require 'shellwords'
require 'tempfile'

namespace :pull do
  def dburl
    Shellwords.escape(`heroku pgbackups:url --remote production`.strip)
  end

  desc 'Clone production db to development'
  task :development => :environment do
    sh "heroku pgbackups:capture --expire --remote production"

    Tempfile.open('dump') do |file|
      sh "curl -o #{file.path} #{dburl}"
      sh "pg_restore --verbose --clean --no-acl --no-owner -d amanikids_website_development #{file.path}"
    end

    User.find_each do |user|
      user.update_attributes(
        :password              => 'secret',
        :password_confirmation => 'secret'
      )
    end
  end

  desc 'Clone production db and s3 data to staging'
  # We can pull the database just fine from our local machine, but it's a BIG
  # WIN to pull the s3 data from heroku, which is inside Amazon's network, and
  # so (a) faster and (b) cheaper, not incurring access fees.
  task :staging => 'pull:staging:db' do
    sh 'heroku rake pull:staging:s3 --remote staging'
  end

  namespace :staging do
    desc 'Clone production db to staging'
    task :db do
      sh "heroku pgbackups:capture --expire --remote production"
      sh "heroku pgbackups:restore #{dburl} --remote staging --confirm amanikids-website-staging"
    end

    desc 'Clone production s3 data to staging'
    task :s3 => :environment do
      require 'aws/s3/bucket_extensions'
      require 'aws/s3/object_extensions'

      AWS::S3::Base.establish_connection!(
        :access_key_id     => ENV['S3_KEY'],
        :secret_access_key => ENV['S3_SECRET']
      )

      source_bucket = 'amanikids'
      target_bucket = 'amanikids-staging'

      AWS::S3::Bucket.find_each(source_bucket) do |object|
        object.copy_to_bucket(target_bucket, :access => :public_read)
      end
    end
  end
end
