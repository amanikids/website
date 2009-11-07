namespace :sass do
  task :update_stylesheets => :environment do
    Sass::Plugin.update_stylesheets
  end
end
