path = ENV['PATH'].split(File::PATH_SEPARATOR)

path.unshift('/opt/local/bin')
path.uniq!

ENV['PATH'] = path.join(File::PATH_SEPARATOR)