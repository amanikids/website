require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  should_have_named_scope :ordered, :order => :position
  should_have_many :pages, :dependent => :destroy
  should_require_attributes :title
end
