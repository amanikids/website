namespace :db do
  namespace :pull do
    desc 'Pull production files to the local filesystem.'
    task :files do
      system 'rsync -rP --delete deploy@amanikids.org:website/production/shared/system/ public/system'
    end
  end
end
