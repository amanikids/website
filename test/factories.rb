Factory.sequence(:slug) do |n|
  Digest::SHA1.hexdigest(n.to_s)
end

Factory.define(:page) do |page|
  page.association :parent, :factory => :section

  page.title 'Hello'
  page.slug { Factory.next(:slug) }
  page.body 'Hi there, and welcome.'
end

Factory.define(:section) do |section|
  section.title 'Something'
  section.slug { Factory.next(:slug) }
end
