module AWS
  module S3
    module ObjectExtensions

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def copy_to_bucket(target_bucket, source_bucket, key, options = {})
          source_last_modified = options[:source_last_modified] || look_up_last_modfied(key, source_bucket)
          target_last_modified = options[:target_last_modified] || look_up_last_modfied(key, target_bucket)
          return if source_last_modified < target_last_modified

          puts "[#{target_bucket}] PUT #{key}"
          source = path!(source_bucket, key)
          target = path!(target_bucket, key)
          put(target, options.merge('x-amz-copy-source' => source))
        end

        def look_up_last_modfied(key, bucket)
          puts "[#{bucket}] GET #{key}"
          find(key, bucket).last_modified
        rescue
          Time.at(0)
        end
      end

      def copy_to_bucket(name, options = {})
        self.class.copy_to_bucket(name, bucket.name, key, options.merge(:source_last_modified => last_modified))
      end

    end
  end
end

AWS::S3::S3Object.send(:include, AWS::S3::ObjectExtensions)
