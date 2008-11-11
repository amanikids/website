ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :galleries, :pages, :sections
  end

  # TODO this page / sub_page weirdness is probably due to the fact that we're not representing Sections in the URLs.
  map.with_options(:controller => 'contents') do |map|
    map.root           :action => 'index', :conditions => { :method => :get }
    map.page '/:slug', :action => 'show',  :conditions => { :method => :get }
  end
end
