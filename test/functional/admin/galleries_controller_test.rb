require 'test_helper'

class Admin::GalleriesControllerTest < ActionController::TestCase
  should_route :get,    '/admin/galleries/new',     :action => 'new'
  should_route :post,   '/admin/galleries',         :action => 'create'
  should_route :get,    '/admin/galleries/42/edit', :action => 'edit',    :id => 42
  should_route :put,    '/admin/galleries/42',      :action => 'update',  :id => 42
  should_route :delete, '/admin/galleries/42',      :action => 'destroy', :id => 42
end
