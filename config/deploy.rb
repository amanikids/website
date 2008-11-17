set :application, 'website'
set :repository,  "git://github.com/amanikids/#{application}.git"

set :deploy_to, "/var/www/apps/#{application}"
set :user, 'deploy'
set :use_sudo, false

set :scm, :git
set :local_repository, '.git'
set :branch, 'master'
set :git_shallow_clone, 1
set :git_enable_submodules, true

server 'amanikids.joyeurs.com', :web, :app, :db, :primary => true, :user => user

namespace :deploy do
  desc 'Restart the Application'
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  namespace :shared do
    desc 'Symlink shared content and configuration'
    task :symlinks do
      run <<-CMD
        rm -rf #{latest_release}/config/database.yml &&
        rm -rf #{latest_release}/config/secret.txt   &&
        rm -rf #{latest_release}/public/photos       &&
        ln -s #{shared_path}/config/database.yml #{latest_release}/config/database.yml &&"
        ln -s #{shared_path}/config/secret.txt   #{latest_release}/config/secret.txt   &&"
        ln -s #{shared_path}/assets/photos       #{latest_release}/public/photos"
      CMD
    end
  end
end

after 'deploy:finalize_update', 'deploy:shared:symlinks'
