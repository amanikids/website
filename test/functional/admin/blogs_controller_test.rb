require 'test_helper'

class Admin::BlogsControllerTest < ActionController::TestCase
  should_route :get,    '/admin/blogs/new',     :action => 'new'
  should_route :post,   '/admin/blogs',         :action => 'create'
  should_route :get,    '/admin/blogs/42/edit', :action => 'edit',    :id => 42
  should_route :put,    '/admin/blogs/42',      :action => 'update',  :id => 42
  should_route :delete, '/admin/blogs/42',      :action => 'destroy', :id => 42
end
