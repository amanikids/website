namespace :s3 do
  task :connect => :environment do
    AWS::S3::Base.establish_connection!(:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'])

    bucket = ENV['S3_BUCKET']

    begin
      puts 'Reading buckets.'
      AWS::S3::Bucket.find(bucket)
    rescue AWS::S3::NoSuchBucket
      puts "Creating #{bucket} bucket."
      AWS::S3::Bucket.create(bucket, :access => :public_read)
    end
  end

  desc 'Upload public/system to s3.'
  task :push => :connect do
    bucket = ENV['S3_BUCKET']

    public_system = Rails.root.join('public', 'system')
    public_system = public_system.readlink while public_system.symlink?

    public_system.find do |path|
      next unless path.file?
      next if     path.basename.to_s == 'maintenance.html'

      key = path.relative_path_from(public_system).to_s
      key = key.sub(%r{^documents/(\d+)/([^/]+)$}, 'documents/\1/original/\2')

      puts "[#{bucket}] EXISTS? #{key}"
      if AWS::S3::S3Object.exists?(key, bucket)
        about = AWS::S3::S3Object.about(key, bucket)

        if about['last-modified'].to_time < path.mtime
          puts "[#{bucket}] STALE #{key}"
        else
          next
        end
      else
        puts "[#{bucket}] NONEXISTENT #{key}"
      end

      puts "[#{bucket}] STORE #{key}"
      path.open do |stream|
        AWS::S3::S3Object.store(key, stream, bucket, :access => :public_read, :cache_control => "public, max-age=#{10.years.to_i}")
      end
    end
  end
end
