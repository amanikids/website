require 'test_helper'

class Admin::PagesControllerTest < ActionController::TestCase
  should_route :get, '/admin/pages', :action => 'index'
end
