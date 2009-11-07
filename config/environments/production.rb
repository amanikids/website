# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Full error reports are disabled and caching is turned off
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = false # we can't use (page|asset) caching on heroku!
config.action_view.cache_template_loading            = true

# See everything in the log (default is :info)
# config.log_level = :debug

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
config.action_controller.asset_host = 'http://assets%d.amanikids.org'

# ActionMailer settings
config.action_mailer.default_url_options = {
  :host => 'amanikids.org'
}

config.action_mailer.smtp_settings = {
  :tls            => true,
  :address        => 'smtp.gmail.com',
  :port           => '587',
  :domain         => 'amanikids.org',
  :authentication => :plain,
  :user_name      => 'no-reply@amanikids.org',
  :password       => ENV['GOOGLE_SECRET']
}

# Enable threaded mode
# config.threadsafe!