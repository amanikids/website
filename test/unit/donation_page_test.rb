require 'test_helper'

class DonationPageTest < ActiveSupport::TestCase
  should_require_attributes :title, :body, :sidebar, :footer

  should_allow_values_for :paypal_account, 'foo@example.com', '', nil
  should_not_allow_values_for :paypal_account, 'this is not an email address'

  context 'without a paypal_account' do
    setup { @donation_page = Factory.build(:donation_page, :paypal_account => nil) }
    should_allow_values_for :currency, '', nil
    should_allow_values_for :donation_amounts, '', nil
  end

  context 'with a paypal_account' do
    setup { @donation_page = Factory.build(:donation_page, :paypal_account => 'foo@example.com') }
    should_allow_values_for :currency, 'GBP'
    should_not_allow_values_for :currency, 'gbp', 'GB', '123', '', nil, :message => 'should be 3 capital letters, like USD'
    should_allow_values_for :donation_amounts, '25,50,75', '25, 50, 75'
    should_not_allow_values_for :donation_amounts, 'a, b, c', '25 50 75', '', nil, :message => 'should be a comma-separated list of numbers'
  end
end
