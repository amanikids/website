require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  should_belong_to :newsletter
  should_require_attributes :title
end
