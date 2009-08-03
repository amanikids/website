ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.root :controller => 'contents', :action => 'index'
    admin.resources :address_lists, :blogs, :documents, :donation_pages, :galleries, :homes, :newsletters, :pages, :photos, :posts, :sections, :two_column_pages
    admin.resource :user_session
  end

  map.resources :newsletters
  map.resources :shares, :path_prefix => '/contents/:content_id'
  map.resources :subscriptions

  # Note, these routes should be last, since /*slugs catches everything.
  map.with_options(:controller => 'contents') do |c|
    c.root                            :action => 'index', :conditions => { :method => :get }
    c.formatted_feed '/feed.:format', :action => 'index', :conditions => { :method => :get }
    c.content        '/*slugs',       :action => 'show',  :conditions => { :method => :get }
  end
end
