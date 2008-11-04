ActionController::Routing::Routes.draw do |map|
  map.with_options(:conditions => { :method => :get }) do |map|
    map.with_options(:controller => 'pages') do |map|
      map.root :action => 'index'
      map.page '/:id', :action => 'show'
    end
  end
end
