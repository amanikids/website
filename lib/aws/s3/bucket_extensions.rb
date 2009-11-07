module AWS
  module S3
    module BucketExtensions
      module ClassMethods

        def find_each(name, options = {})
          loop do
            puts "[#{name}] FIND #{options.inspect}"
            bucket = find(name, options)

            bucket.each do |object|
              yield object
              options[:marker] = object.key
            end

            break unless bucket.is_truncated
          end
        end

      end
    end
  end
end

AWS::S3::Bucket.extend(AWS::S3::BucketExtensions::ClassMethods)
