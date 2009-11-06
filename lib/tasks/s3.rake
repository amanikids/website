namespace :s3 do
  task :connect => :environment do
    AWS::S3::Base.establish_connection!(:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'])

    bucket = ENV['S3_BUCKET']

    begin
      puts 'Reading buckets...'
      AWS::S3::Bucket.find(bucket)
    rescue AWS::S3::NoSuchBucket
      puts "Creating #{bucket} bucket..."
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

      STDOUT.write "[#{bucket}] Looking for #{key}... "; STDOUT.flush
      if AWS::S3::S3Object.exists?(key, bucket)
        about = AWS::S3::S3Object.about(key, bucket)

        if about['last-modified'].to_time < path.mtime
          puts 'STALE.'
        else
          puts 'ok.'
          next
        end
      else
        puts 'NIL.'
      end

      puts "Storing #{key}..."
      path.open do |stream|
        AWS::S3::S3Object.store(key, stream, bucket, :access => :public_read, :cache_control => "public, max-age=#{10.years.to_i}")
      end
    end
  end

  desc 'Renamespace documents.'
  task :renamespace_documents => :connect do
    bucket = ENV['S3_BUCKET']

    OLD_PATTERN = %r{^documents/(\d+)/([^/]+)$}
    NEW_REPLACE = 'documents/\1/original/\2'

    AWS::S3::Bucket.objects(bucket, :prefix => 'documents').each do |object|
      old_key = object.key
      new_key = old_key.sub(OLD_PATTERN, NEW_REPLACE)

      unless old_key == new_key
        puts "[#{bucket}] Renaming #{old_key} -> #{new_key}..."
        object.rename(new_key)
      end
    end
  end
end
