require 'test_helper'

class ShareTest < ActiveSupport::TestCase
  should_belong_to :content

  should_require_attributes :from, :to
  should_not_allow_values_for :from, 'bob'
  should_not_allow_values_for :to, 'bob'
  should_have_instance_methods :message, :message=
end
