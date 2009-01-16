require 'test_helper'

class Admin::TwoColumnPagesControllerTest < ActionController::TestCase
  should_route :get,    '/admin/two_column_pages/new',     :action => 'new'
  should_route :post,   '/admin/two_column_pages',         :action => 'create'
  should_route :get,    '/admin/two_column_pages/42/edit', :action => 'edit',    :id => 42
  should_route :put,    '/admin/two_column_pages/42',      :action => 'update',  :id => 42
  should_route :delete, '/admin/two_column_pages/42',      :action => 'destroy', :id => 42
end
