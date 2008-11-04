require 'test_helper'

class Admin::SectionsControllerTest < ActionController::TestCase
  should_route :get, '/admin/sections', :action => 'index'
end
