set :application, 'website'
set :repository,  "git://github.com/amanikids/#{application}.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"
set :user, 'deploy'
set :group_writable, true
set :use_sudo, false

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :local_repository, '.git'
set :branch, 'master'
set :git_shallow_clone, 1
set :git_enable_submodules, true

server 'amanikids.joyeurs.com', :web, :app, :db, :primary => true, :user => user
