ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.root :controller => 'contents', :action => 'index'
    admin.resources :blogs, :galleries, :homes, :pages, :posts, :sections
    admin.resource :user_session
  end

  map.with_options(:controller => 'contents') do |c|
    c.root                            :action => 'index', :conditions => { :method => :get }
    c.formatted_feed '/feed.:format', :action => 'index', :conditions => { :method => :get }
    c.connect        '/*slugs',       :action => 'show',  :conditions => { :method => :get }
  end
end
