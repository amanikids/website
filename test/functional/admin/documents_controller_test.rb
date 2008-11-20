require 'test_helper'

class Admin::DocumentsControllerTest < ActionController::TestCase
  should_route :post,   '/admin/documents',    :action => 'create'
  should_route :delete, '/admin/documents/42', :action => 'destroy', :id => 42
end
