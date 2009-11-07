namespace :git do
  task :precommit => ['sass:update_stylesheets', 'asset:packager:build_all'] do
    system 'git add public/javascripts/*_packaged.js'
    system 'git add public/stylesheets/*_packaged.css'
  end
end
