namespace :contents do
  desc 'Update old public/system links to reference s3.'
  task :update_document_links => :environment do
    OLD = %r{(:|!)/system/documents/(\d+)/([^?]+)}
    NEW = "\\1http://#{ENV['S3_BUCKET']}.s3.amazonaws.com/documents/\\2/original/\\3"

    Content.find_each do |content|
      content.text_columns.each do |column|
        content[column] = content[column].gsub(OLD, NEW) unless content[column].nil?
      end
      content.save
    end
  end
end
