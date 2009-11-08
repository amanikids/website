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

# TODO it would be better to read the Gemfile itself!
depend :remote, :gem, 'bundler',        '>= 0.7.0'
depend :remote, :gem, 'rack',           '= 1.0.1'
depend :remote, :gem, 'rails',          '= 2.3.4'
depend :remote, :gem, 'rake',           '>= 0.8.3'
depend :remote, :gem, 'activesupport',  '= 2.3.4'
depend :remote, :gem, 'activerecord',   '= 2.3.4'
depend :remote, :gem, 'actionpack',     '= 2.3.4'
depend :remote, :gem, 'actionmailer',   '= 2.3.4'
depend :remote, :gem, 'activeresource', '= 2.3.4'
depend :remote, :gem, 'RedCloth',       '>= 4.0.3'

namespace :deploy do
  desc 'Restart the Application'
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :s3 do
  desc 'Copy s3 production data to current environment.'
  task :pull do
    rake      = fetch(:rake, 'rake')
    rails_env = fetch(:rails_env, 'production')
    run "cd #{latest_release}; #{rake} RAILS_ENV=#{rails_env} s3:pull"
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

after 'deploy:update_code' do
  run "cd #{latest_release}; gem bundle"
end

after 'deploy:update_code', 'tapsuey:db:pull'
# I'm leaving this one commented out by default since it takes an annoying-long amount of time.
# after 'deploy:update_code', 's3:pull'
