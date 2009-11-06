namespace :s3 do
  task :connect => :environment do
    AWS::S3::Base.establish_connection!(:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'])

    puts 'Reading buckets...'
    buckets = AWS::S3::Bucket.list

    unless buckets.map(&:name).include?(ENV['S3_BUCKET'])
      puts "Creating #{ENV['S3_BUCKET']} bucket..."
      AWS::S3::Bucket.create(ENV['S3_BUCKET'], :access => :public_read)
    end
  end

  desc 'Upload public/system to s3.'
  task :push => :connect do
    bucket = AWS::S3::Bucket.find(ENV['S3_BUCKET'])

    public_system = Rails.root.join('public', 'system')
    public_system.find do |path|
      next unless path.file?

      key    = path.relative_path_from(public_system).to_s
      object = bucket[key] || bucket.new_object

      if object.stored?
        STDOUT.write "[#{bucket.name}] Checking #{key}... "; STDOUT.flush
        last_modified = bucket[key].about['last-modified'].to_time

        if last_modified < path.mtime
          puts 'STALE.'
        else
          puts 'ok.'
          next
        end
      end

      puts "[#{bucket.name}] Storing #{key}..."
      path.open do |stream|
        object.key   = key
        object.value = stream
        object.store(:access => :public_read, :cache_control => "public, max-age=#{10.years.to_i}")
      end
    end
  end
end
