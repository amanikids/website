atom_feed do |feed|
  feed.title "Amani Children's Home | Moshi, Tanzania"
  feed.updated @contents.first.updated_at

  feed.author do |author|
    author.name 'Website'
    author.email 'info@amanikids.org'
  end

  @contents.select(&:path).each do |content|
    feed.entry(content, :url => content.path) do |entry|
      entry.title(content.title)
      entry.content(textilize(content.body) + image_tag(content.photo.url(:small)), :type => 'html')
    end
  end
end