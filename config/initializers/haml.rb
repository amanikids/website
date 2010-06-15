# Tell Haml to wrap html attributes with double instead of single quotes.
Haml::Template.options[:attr_wrapper] = '"'

# Tell Sass where our stylesheets are.
Sass::Plugin.options[:template_location] = Rails.root.join('app', 'views', 'stylesheets').to_s
Sass::Plugin.options[:css_location]      = Rails.root.join('tmp', 'stylesheets').to_s
