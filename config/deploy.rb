set :application, 'website'
set :repository,  "git://github.com/amanikids/#{application}.git"

set :deploy_to, "/var/www/apps/#{application}"
set :user, 'deploy'
set :use_sudo, false

set :scm, :git
set :branch, 'master'
set :deploy_via, :remote_cache
set :git_enable_submodules, true

server 'amanikids.joyeurs.com', :web, :app, :db, :primary => true, :user => user

namespace :deploy do
  desc 'Restart the Application'
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after 'deploy:finalize_update' do
  shared_resources = ['config/database.yml', 'config/secret.txt', 'config/tapsuey.txt', 'public/documents', 'public/photos']
  symlink_commands = shared_resources.map { |path| "rm -rf #{latest_release}/#{path}; ln -s #{shared_path}/#{path} #{latest_release}/#{path}" }
  run symlink_commands.join(';')
end
