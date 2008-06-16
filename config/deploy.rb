set :application,       'set your application name here'
set :repository,        'set your repository location here'
set :database_name,     'set your database name here'
set :database_username, 'set your database username here'

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :git
# set :git_shallow_clone, 1

server 'your server here', :web, :app, :db, :primary => true
