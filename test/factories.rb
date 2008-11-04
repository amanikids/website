Factory.define(:page) do |page|
  page.association :section

  page.title 'Hello'
  page.slug 'hello'
  page.body 'Hi there, and welcome.'
end

Factory.define(:section) do |section|
  section.title 'Something'
end
