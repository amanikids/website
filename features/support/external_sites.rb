Capybara.app = Rack::URLMap.new(
  'http://www.events.org/' =>
    lambda { |env| [200, {}, []] },
  'http://www.example.com/' =>
    Capybara.app
)
