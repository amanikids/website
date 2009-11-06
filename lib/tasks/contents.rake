namespace :contents do
  task :fix_image_links => :environment do
    OLD = %r{!/?documents}
    NEW = '!/system/documents'

    Content.transaction do
      Content.find_each do |content|
        content.text_columns.each do |column|
          content[column] = content[column].gsub(OLD, NEW) unless content[column].nil?
        end
        content.save!
      end
    end
  end
end