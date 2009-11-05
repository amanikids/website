namespace :move do
  task :attachments => :environment do
    Content.find_each do |content|
      if content.any_text_matches?(%r{:/(documents|photos)/})
        content.text_columns.each do |column_name|
          if content[column_name]
            content[column_name] = content[column_name].gsub(%r{:/(documents|photos)/}, ':/system/\1/')
          end
        end
        content.save!
      end
    end
  end
end
