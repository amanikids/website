set :application, 'website'
set :repository,  "git://github.com/amanikids/#{application}.git"

set(:deploy_to) { "/var/www/apps/#{application}/#{rails_env}" }
set :shared_children, %w(system log pids config)
set :user, 'deploy'
set :use_sudo, false

set :rails_env, 'staging'

task :production do
  set :rails_env, 'production'
end

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
  shared_resources = ['config/database.yml', 'config/secret.txt', 'config/tapsuey.txt']
  symlink_commands = shared_resources.map { |path| "rm -rf #{latest_release}/#{path}; ln -s #{shared_path}/#{path} #{latest_release}/#{path}" }
  run symlink_commands.join(';')
end

after 'deploy:update_code', 'tapsuey:db:pull'
after 'deploy:update_code', 'db:pull:files'

namespace :db do
  namespace :pull do
    # I'd rather just have `rake db:pull` depend on `rake db:pull:files`, but I
    # don't have enough memory in production the rsync/ssh overhead. Sigh. Eagerly
    # awaing the move to Heroku!
    desc 'Pull production files to the latest release.'
    task :files do
      rails_env = fetch(:rails_env, 'production')
      unless rails_env == 'production'
        run <<-CMD
          rm -rf #{shared_path}/system &&
          cp -r /var/www/apps/#{application}/production/shared/system #{shared_path}
        CMD
      end
    end
  end
end
