require 'test_helper'

class Admin::PhotosControllerTest < ActionController::TestCase
  should_route :post,   '/admin/photos',    :action => 'create'
  should_route :put,    '/admin/photos/42', :action => 'update',  :id => 42
  should_route :delete, '/admin/photos/42', :action => 'destroy', :id => 42
end
