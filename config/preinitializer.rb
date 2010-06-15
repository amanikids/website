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

# =====================================================================
# Use bundler.
# =====================================================================
begin
  # Require the preresolved locked set of gems.
  require File.expand_path('../../.bundle/environment', __FILE__)
rescue LoadError
  # Fallback on doing the resolve at runtime.
  require "rubygems"
  require "bundler"
  if Bundler::VERSION <= "0.9.5"
    raise RuntimeError, "Bundler incompatible.\n" +
      "Your bundler version is incompatible with Rails 2.3 and an unlocked bundle.\n" +
      "Run `gem install bundler` to upgrade or `bundle lock` to lock."
  else
    Bundler.setup
  end
end

