%w( rubygems wordpress ).each { |lib| require lib }
WORDPRESS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
