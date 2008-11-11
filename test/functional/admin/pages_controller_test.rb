require 'test_helper'

class Admin::PagesControllerTest < ActionController::TestCase
  should_route :get,    '/admin/pages/new',     :action => 'new'
  should_route :post,   '/admin/pages',         :action => 'create'
  should_route :get,    '/admin/pages/42/edit', :action => 'edit',    :id => 42
  should_route :put,    '/admin/pages/42',      :action => 'update',  :id => 42
  should_route :delete, '/admin/pages/42',      :action => 'destroy', :id => 42
end
