require 'test_helper'

class Admin::PostsControllerTest < ActionController::TestCase
  should_route :get,    '/admin/posts/new',     :action => 'new'
  should_route :post,   '/admin/posts',         :action => 'create'
  should_route :get,    '/admin/posts/42/edit', :action => 'edit',    :id => 42
  should_route :put,    '/admin/posts/42',      :action => 'update',  :id => 42
  should_route :delete, '/admin/posts/42',      :action => 'destroy', :id => 42
end
