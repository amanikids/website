require 'test_helper'

class MailerTest < ActionMailer::TestCase
  context 'given a Share' do
    setup { @share = Factory.build(:share) }

    context 'share_created' do
      setup { @message = Mailer.create_share_created(@share) }

      should 'be sent to share.to' do
        assert_equal [@share.to], @message.to
      end

      should 'have reply-to share.from' do
        assert_equal [@share.from], @message.reply_to
      end

      should 'be from site' do
        assert_equal [ActionMailer::Configuration.site_address], @message.from
      end

      should 'have link to page' do
        assert_match "http://shoes.local:3000#{@share.content.path}", @message.body
      end

      should 'include message' do
        assert_match @share.message, @message.body
      end

      should 'have a subject' do
        assert !@message.subject.blank?
      end
    end
  end
end
