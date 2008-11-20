require 'test_helper'

class ShareTest < ActiveSupport::TestCase
  should_belong_to :content

  should_require_attributes :from, :to
  should_not_allow_values_for :from, 'bob'
  should_not_allow_values_for :to, 'bob'
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
end
