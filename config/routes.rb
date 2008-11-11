ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.root :controller => 'contents', :action => 'index'
    admin.resources :galleries, :pages, :sections
  end

  map.with_options(:controller => 'contents') do |c|
    c.root               :action => 'index', :conditions => { :method => :get }
    c.connect '/*slugs', :action => 'show',  :conditions => { :method => :get }
  end
end
