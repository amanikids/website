ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :pages, :sections
  end

  # TODO this page / sub_page weirdness is probably due to the fact that we're not representing Sections in the URLs.
  map.with_options(:controller => 'pages') do |map|
    map.root                           :action => 'index', :conditions => { :method => :get }
    map.connect '/:slug',              :action => 'show',  :conditions => { :method => :get }
    map.connect '/:parent_slug/:slug', :action => 'show',  :conditions => { :method => :get }
  end
end
