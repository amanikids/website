require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  should_belong_to :content
end