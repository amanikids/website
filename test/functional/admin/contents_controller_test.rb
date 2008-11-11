require 'test_helper'

class Admin::ContentsControllerTest < ActionController::TestCase
  should_route :get, '/admin', :action => 'index'
end
