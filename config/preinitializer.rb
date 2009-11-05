# This is a nice way to use heroku-style environment variables locally.
environment_variables = File.join(RAILS_ROOT, 'config', 'environment_variables.rb')
load(environment_variables) if File.exists?(environment_variables)

# You'll need to set the following:
# ENV['SESSION_SECRET'] = ''
# ENV['TAPSUEY_SECRET'] = ''
