ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :pages, :sections
  end

  map.with_options(:controller => 'pages') do |map|
    map.root         :action => 'index', :conditions => { :method => :get }
    map.page '/:id', :action => 'show',  :conditions => { :method => :get }
  end
end
