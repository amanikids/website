require 'test_helper'

class NewsletterTest < ActiveSupport::TestCase
  should_have_many :articles
  should_validate_presence_of :published_on

  should_allow_values_for     :unsubscribe_url, 'http://example.com', '', nil
  should_not_allow_values_for :unsubscribe_url, 'example.com'

  context 'create' do
    setup do
      @newsletter = Factory.create(:newsletter, :published_on => Date.new(2009, 8, 5))
    end

    should 'adjust published_on to the first of the month' do
      assert_equal(1, @newsletter.published_on.day)
    end

    should 'include the year and the month in the slug' do
      assert_equal('200908', @newsletter.slug)
    end

    should 'include the year and the month in the title' do
      assert_equal('Amani Newsletter - August 2009', @newsletter.title)
    end
  end

  context 'with an existing newsletter' do
    setup { Factory.create(:newsletter) }
    should_validate_uniqueness_of :published_on
  end

  should 'return the appropriate newsletter from find_by_slug!' do
    newsletter = Factory.create(:newsletter)
    assert_equal(newsletter, Newsletter.find_by_slug!(newsletter.slug))
  end

  should "raise if can't find_by_slug!" do
    assert_raise(ActiveRecord::RecordNotFound) do
      Newsletter.find_by_slug!('200910')
    end
  end

  should "raise if invalid slug passed find_by_slug!" do
    assert_raise(ActiveRecord::RecordNotFound) do
      Newsletter.find_by_slug!('20013')
    end
  end
end
