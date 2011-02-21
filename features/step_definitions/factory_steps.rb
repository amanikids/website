Given /^a home page has been created for the website$/ do
  Home.create!(
    :title => 'Karibu!',
    :body  => 'Thanks for stopping by.'
  )
end
