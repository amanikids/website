Factory.sequence(:email) do |n|
  "#{n}@example.com"
end

Factory.sequence(:slug) do |n|
  "slug#{n}"
end



Factory.define(:donation_page) do |donation_page|
end

Factory.define(:home) do |home|
  home.title 'Home'
  home.body 'Hi there, and welcome.'
end

Factory.define(:newsletter) do |newsletter|
  newsletter.published_on Date.today
end

Factory.define(:page) do |page|
  page.association :parent, :factory => :section
  page.title 'Page'
  page.slug { Factory.next(:slug) }
  page.body 'This is a page.'
end

Factory.define(:photo) do |photo|
  photo.association :content, :factory => :page
  photo.photo ActionController::TestUploadedFile.new(Rails.root.join('test', 'data', 'photo.jpg').to_s, 'image/jpeg', :binary)
end

Factory.define(:section) do |section|
  section.title 'Section'
  section.slug { Factory.next(:slug) }
end

Factory.define(:share) do |share|
  share.to_address   { Factory.next(:email) }
  share.to_name 'Bob'
  share.from_address { Factory.next(:email) }
  share.from_name 'Fred'
  share.message "Thought you'd appreciate this."
  share.association :content, :factory => :page
end

Factory.define(:subscription) do |subscription|
  subscription.name 'Bob'
  subscription.email 'bob@example.com'
end