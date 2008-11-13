# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

# Loads tasks from any unpacked gems.
# FIXME perhaps a future version of Rails will do this automatically?
Dir["#{RAILS_ROOT}/vendor/gems/*/tasks/*.rake"].sort.each { |ext| load ext }
