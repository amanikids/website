require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  should_validate_presence_of :name
  should_validate_email_veracity_of :email

  should 'validate confirmation of email' do
    subscription = Factory.build(:subscription, :email_confirmation => '')
    subscription.valid?
    assert subscription.errors.on(:email)
  end

  context 'with an unsaved Subscription' do
    setup { @subscription = Factory.build(:subscription) }

    context 'save' do
      setup { @subscription.save! }
      before_should 'send email' do
        Mailer.expects(:deliver_subscription_created).with(@subscription)
      end
    end
  end
end
