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
  run <<-CMD
    rm -rf #{latest_release}/config/database.yml &&
    rm -rf #{latest_release}/config/environment_variables.rb &&
    ln -s #{shared_path}/config/database.yml             #{latest_release}/config/database.yml &&
    ln -s #{shared_path}/config/environment_variables.rb #{latest_release}/config/environment_variables.rb
  CMD
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
          cp -rp /var/www/apps/#{application}/production/shared/system #{shared_path}
        CMD
      end
    end
  end
end

namespace :contents do
  task :update_document_links do
    rake      = fetch(:rake, 'rake')
    rails_env = fetch(:rails_env, 'production')
    run "cd #{latest_release}; #{rake} RAILS_ENV=#{rails_env} contents:update_document_links"
  end
end
