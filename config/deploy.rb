# In all its glory:
set :application, 'amanikids_org'

# Gotta love this new way of writing it.
server 'woodward.joyent.us', :web, :user => 'matthew'

# Git rawks, yo!
set :scm, :git
set :local_repository, "woodward:git/#{application}.git"
set :repository, "/users/home/matthew/domains/git.matthewtodd.org/var/lib/repos/#{application}.git"
set :git_shallow_clone, 1

# I'm liking the /var these days
set :deploy_to, '/users/home/matthew/domains/amanikids.org/var/www'

# Database config parameters. It would be nice to determine the username automatically, though.
set :database_name,     'matthew_amanikids_wordpress'
set :database_username, 'matthew'
