# Generated by the asset_copier plugin
# http://github.com/pelargir/asset_copier

require File.expand_path(File.dirname(__FILE__) + '/../lib/textile_toolbar/asset_copier')

namespace :textile_toolbar do
  desc "Install files required by textile_toolbar"
  task :install do  
    TextileToolbar::AssetCopier.copy "textile_toolbar"
  end
end