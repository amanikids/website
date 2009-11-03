# Your production HTTP host.
# (Taps will attempt to pull data from http://amanikids.org/tapsuey.)
Tapsuey.host = 'amanikids.org'

# Will need to be the *same* for development and production, but should not be
# checked into version control, of course. Arrange for your deployment scripts
# to symlink config/tapsuey.txt in the current release.
# Alternatively, you could also use something like ENV['TAPSUEY_PASSWORD'].
# But you know how to do this kind of thing.
Tapsuey.password = Rails.root.join('config', 'tapsuey.txt').read.strip

# You can also set the following. (Defaults are shown.)
# Tapsuey.scheme     = 'http'    # or 'https'
# Tapsuey.port       = nil       # or 3000, for poking around locally
# Tapsuey.username   = 'tapsuey'
# Tapsuey.chunk_size = 1000      # see Taps::ClientSession

# Taps is a little funky in that it calls back out to its own `schema` script,
# requiring that ruby be in your PATH. If you see "primary key must be unique"
# kinds of errors when re-pulling from production, try something like this:
path = ENV['PATH'].split(File::PATH_SEPARATOR)
path.unshift('/opt/local/bin')
path.uniq!
ENV['PATH'] = path.join(File::PATH_SEPARATOR)
