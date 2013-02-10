RAILS_GEM_VERSION = '2.3.16' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.frameworks -= [ :active_resource ]

  config.middleware.use 'Redirector',
    '/ride' => 'http://www.events.org/sponsorshipteams.aspx?event=31734&team=116'

  config.middleware.use 'Rack::CanonicalHost',
    ENV['CANONICAL_HOST']

  config.middleware.use 'Rack::Static',
    :urls => ['/stylesheets'],
    :root => Rails.root.join('tmp')

  config.time_zone = 'UTC'
end
