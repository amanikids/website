namespace :db do
  desc 'Pull production data to a local database.'
  task :pull => :environment do
    Tapsuey.pull unless Rails.env.production?
  end
end
