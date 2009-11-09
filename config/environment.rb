RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')
require 'rack-canonical-host'

Rails::Initializer.run do |config|
  config.frameworks -= [ :active_resource ]
  config.middleware.use Rack::CanonicalHost, ENV['CANONICAL_HOST']
  config.time_zone = 'UTC'
end
