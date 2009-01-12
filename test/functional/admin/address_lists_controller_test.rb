require 'test_helper'

class Admin::AddressListsControllerTest < ActionController::TestCase
  should_route :get,    '/admin/address_lists',        :action => 'index'
  should_route :get,    '/admin/address_lists/new',    :action => 'new'
  should_route :post,   '/admin/address_lists',        :action => 'create'
  should_route :get,    '/admin/address_lists/42.txt', :action => 'show',    :id => 42, :format => 'txt'
  should_route :delete, '/admin/address_lists/42',     :action => 'destroy', :id => 42
end
