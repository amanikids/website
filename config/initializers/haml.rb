# Apparently you have to say this when Haml's a vendored gem but not installed outside this project.
Haml.init_rails(binding)

# Tell Haml to wrap html attributes with double instead of single quotes.
Haml::Template.options[:attr_wrapper] = '"'

# Tell Sass where our stylesheets are.
Sass::Plugin.options[:template_location] = Rails.root.join('app', 'views', 'stylesheets').to_s

# No-op dump Sass output in /tmp on Heroku. We don't need the full
# http://github.com/heroku/sass_on_heroku plugin since we're already using
# asset_packager anyway.
if Rails.env.production?
  Sass::Plugin.options[:css_location] = Rails.root.join('tmp', 'sass').to_s
end
