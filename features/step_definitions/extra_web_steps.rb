Then /^I should be at "([^"]+)"$/ do |host|
  current_host = URI.parse(current_url).host
  if current_host.respond_to? :should
    current_host.should == host
  else
    assert_equal host, current_host
  end
end
