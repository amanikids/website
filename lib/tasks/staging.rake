require 'shellwords'

namespace :staging do
  namespace :db do
    def dburl
      Shellwords.escape(`heroku pgbackups:url --remote production`.strip)
    end

    desc 'Clone production db to staging'
    task :pull do
      sh "heroku pgbackups:capture --expire --remote production"
      sh "heroku pgbackups:restore #{dburl} --remote staging --confirm amanikids-staging"
    end
  end
end
