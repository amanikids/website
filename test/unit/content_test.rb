require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  should_have_many :photos
end