require 'test_helper'

class ShareTest < ActiveSupport::TestCase
  should_belong_to :content

  should_validate_presence_of :from_name, :to_name
  should_validate_email_veracity_of :from_address, :to_address
  should_have_instance_methods :message, :message=

  context 'with an unsaved Share' do
    setup { @share = Factory.build(:share) }

    context 'save' do
      setup { @share.save! }
      before_should 'send email' do
        Mailer.expects(:deliver_share_created).with(@share)
      end
    end
  end

  should 'combine from_name and from_address for from' do
    assert_equal 'Bob <bob@example.com>', Share.new(:from_name => 'Bob', :from_address => 'bob@example.com').from
  end

  should 'combine to_name and to_address for to' do
    assert_equal 'Bob <bob@example.com>', Share.new(:to_name => 'Bob', :to_address => 'bob@example.com').to
  end
end
