require 'test_helper'

class DonationPageTest < ActiveSupport::TestCase
  should_require_attributes :title, :body, :sidebar, :footer
end
