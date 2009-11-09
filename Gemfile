bin_path 'vendor/bundler_gems/bin'
bundle_path 'vendor/bundler_gems'
clear_sources
source 'http://gemcutter.org'

# We can reasonably expect these gems to be installed anywhere, so we don't bundle them.
gem 'rails',          '= 2.3.4', :bundle => false
gem 'rake',           '= 0.8.7', :bundle => false
gem 'activesupport',  '= 2.3.4', :bundle => false
gem 'activerecord',   '= 2.3.4', :bundle => false
gem 'actionpack',     '= 2.3.4', :bundle => false
gem 'actionmailer',   '= 2.3.4', :bundle => false
gem 'activeresource', '= 2.3.4', :bundle => false
gem 'RedCloth',       '= 4.1.9', :bundle => false

gem 'authlogic'
gem 'aws-s3', :require_as => 'aws/s3'
gem 'fastercsv'
gem 'haml'
gem 'paperclip'
gem 'rack'
gem 'rack-canonical-host'

only :test do
  gem 'factory_girl'
  gem 'mocha', :require_as => []
  gem 'shoulda'
end
