require 'test_helper'

class Admin::DonationPagesControllerTest < ActionController::TestCase
  should_route :get,    '/admin/donation_pages/new',     :action => 'new'
  should_route :post,   '/admin/donation_pages',         :action => 'create'
  should_route :get,    '/admin/donation_pages/42/edit', :action => 'edit',    :id => 42
  should_route :put,    '/admin/donation_pages/42',      :action => 'update',  :id => 42
  should_route :delete, '/admin/donation_pages/42',      :action => 'destroy', :id => 42
end
