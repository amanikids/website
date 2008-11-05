require 'test_helper'

class PageTest < ActiveSupport::TestCase
  should_require_attributes :title, :slug, :body
  should_allow_values_for :slug, 'this-is-a-good-slug'
  should_not_allow_values_for :slug, 'this has spaces', 'THIS HAS CAPITAL LETTERS', 'this.has?punctuation'
end
