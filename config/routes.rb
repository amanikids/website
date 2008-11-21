ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.root :controller => 'contents', :action => 'index'
    admin.resources :blogs, :documents, :galleries, :homes, :pages, :posts, :sections
    admin.resource :user_session
  end

  map.resources :shares, :path_prefix => '/contents/:content_id'

  # Note, these routes should be last, since /*slugs catches everything.
  map.with_options(:controller => 'contents') do |c|
    c.root                            :action => 'index', :conditions => { :method => :get }
    c.formatted_feed '/feed.:format', :action => 'index', :conditions => { :method => :get }
    c.content        '/*slugs',       :action => 'show',  :conditions => { :method => :get }
  end
end
