require 'test_helper'

class Admin::SectionsControllerTest < ActionController::TestCase
  should_route :get,    '/admin/sections/new',     :action => 'new'
  should_route :post,   '/admin/sections',         :action => 'create'
  should_route :get,    '/admin/sections/42/edit', :action => 'edit',    :id => 42
  should_route :put,    '/admin/sections/42',      :action => 'update',  :id => 42
  should_route :delete, '/admin/sections/42',      :action => 'destroy', :id => 42
end
