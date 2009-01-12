require 'test_helper'

class AddressListTest < ActiveSupport::TestCase
  should 'include nothing by default' do
    address_list = AddressList.create
    assert_equal [], really_reload(address_list).addresses
  end

  should 'include email addresses from subscriptions' do
    subscription = Factory(:subscription)
    address_list = AddressList.create(:subscriptions => [subscription])
    assert_equal [subscription.email], really_reload(address_list).addresses
  end

  should 'include email addresses from csv_files' do
    csv_file = StringIO.new('Bob, bob@example.com')
    address_list = AddressList.create(:csv_files => [csv_file])
    assert_equal ['bob@example.com'], really_reload(address_list).addresses
  end

  should 'lowercase email addresses' do
    address_list = AddressList.create(:subscriptions => [Factory.build(:subscription, :email => 'Bob@Example.COM')])
    assert_equal ['bob@example.com'], really_reload(address_list).addresses
  end

  should 'strip email addresses' do
    address_list = AddressList.create(:subscriptions => [Factory.build(:subscription, :email => ' bob@example.com ')])
    assert_equal ['bob@example.com'], really_reload(address_list).addresses
  end

  should 'sort email addresses' do
    address_list = AddressList.create(:subscriptions => [Factory.build(:subscription, :email => '2@example.com'), Factory.build(:subscription, :email => '1@example.com')])
    assert_equal ['1@example.com', '2@example.com'], really_reload(address_list).addresses
  end

  should 'uniq email addresses' do
    address_list = AddressList.create(:subscriptions => [Factory.build(:subscription, :email => 'duplicate@example.com'), Factory.build(:subscription, :email => 'duplicate@example.com')])
    assert_equal ['duplicate@example.com'], really_reload(address_list).addresses
  end
end
