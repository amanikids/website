# =====================================================================
# This is a nice way to use heroku-style environment variables locally.
# =====================================================================
environment_variables = File.join(RAILS_ROOT, 'config', 'environment_variables.rb')
load(environment_variables) if File.exists?(environment_variables)

# You'll need to set the following:
# ENV['CANONICAL_HOST'] = '' # Actually, this one's optional.
# ENV['GOOGLE_SECRET']  = ''
# ENV['S3_BUCKET']      = ''
# ENV['S3_KEY']         = ''
# ENV['S3_SECRET']      = ''
# ENV['SESSION_SECRET'] = ''
# ENV['TAPSUEY_SECRET'] = ''

# =====================================================================
# Use bundler.
# =====================================================================
require "#{File.dirname(__FILE__)}/../vendor/bundler_gems/environment"
