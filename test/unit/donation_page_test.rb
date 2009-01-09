require 'test_helper'

class DonationPageTest < ActiveSupport::TestCase
  should_require_attributes :title, :body, :sidebar, :footer, :one_time_donation_title, :monthly_donation_title

  should_allow_values_for :paypal_account, 'foo@example.com', '', nil
  should_not_allow_values_for :paypal_account, 'this is not an email address'

  context 'without an online_donation_method' do
    setup { @donation_page = Factory.build(:donation_page, :online_donation_method => nil) }
    should_allow_values_for :currency, '', nil
    should_allow_values_for :donation_amounts, '', nil
  end

  context 'with online_donation_method ANYTHING' do
    setup { @donation_page = Factory.build(:donation_page, :online_donation_method => 'ANYTHING') }
    should_allow_values_for :paypal_account, '', nil
    should_allow_values_for :currency, 'GBP'
    should_not_allow_values_for :currency, 'gbp', 'GB', '123', '', nil, :message => 'should be 3 capital letters, like USD'
    should_allow_values_for :donation_amounts, '25,50,75', '25, 50, 75'
    should_not_allow_values_for :donation_amounts, 'a, b, c', '25 50 75', '', nil, :message => 'should be a comma-separated list of numbers'
  end

  context 'with online_donation_method paypal' do
    setup { @donation_page = Factory.build(:donation_page, :online_donation_method => 'paypal') }
    should_allow_values_for :paypal_account, 'foo@example.com'
    should_not_allow_values_for :paypal_account, 'not an email address', '', nil
  end

  should 'provide list of donation amounts' do
    donation_page = Factory.build(:donation_page, :donation_amounts => '25, 50, 75')
    assert_equal [25, 50, 75], donation_page.donation_amounts_list
  end
end
