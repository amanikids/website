# =====================================================================
# This is a nice way to use heroku-style environment variables locally.
# =====================================================================
environment_variables = File.join(RAILS_ROOT, 'config', 'environment_variables.rb')
load(environment_variables) if File.exists?(environment_variables)

# You'll need to set the following:
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

class Rails::Boot
  def run
    load_initializer
    extend_environment
    Rails::Initializer.run(:set_load_path)
  end

  def extend_environment
    Rails::Initializer.class_eval do
      old_load = instance_method(:load_environment)
      define_method(:load_environment) do
        Bundler.require_env RAILS_ENV
        old_load.bind(self).call
      end
    end
  end
end
