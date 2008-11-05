namespace :db do
  desc 'Populate database with real data.'
  task :bootstrap => :environment do
    require 'active_record/fixtures'
    ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
    Dir.glob(File.join(RAILS_ROOT, 'db', 'bootstrap', '*.{yml,csv}')).each do |fixture_file|
      Fixtures.create_fixtures('db/bootstrap', File.basename(fixture_file, '.*'))
    end
  end

  desc 'Reset migrations, cloning structure to test, and populate database with real data.'
  task :refresh => ['db:migrate:reset', 'db:test:clone', 'db:bootstrap']
end
