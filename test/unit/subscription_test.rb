require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  should_require_attributes :name
  should_validate_email_veracity_of :email

  should 'validate confirmation of email' do
    subscription = Factory.build(:subscription, :email_confirmation => '')
    subscription.valid?
    assert subscription.errors.on(:email)
  end
end
