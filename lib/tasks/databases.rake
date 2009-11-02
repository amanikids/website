namespace :db do
  namespace :pull do
    desc 'Pull production files to the local filesystem.'
    task :files do
      system 'rsync -rP --delete deploy@amanikids.org:website/shared/public/documents/ public/documents'
      system 'rsync -rP --delete deploy@amanikids.org:website/shared/public/photos/    public/photos'
    end
  end

  # task :pull => 'db:pull:files'
end
