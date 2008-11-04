require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  should_have_named_scope :ordered, :order => :position
  should_have_many :pages
  should_require_attributes :title
  # TODO install acts_as_list plugin to keep Section position properly updated
end
