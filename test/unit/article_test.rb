require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  should_belong_to :newsletter
  should_validate_presence_of :title
end
