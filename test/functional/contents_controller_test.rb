require 'test_helper'

class ContentsControllerTest < ActionController::TestCase
  should_route :get, '/', :action => 'index'
end
