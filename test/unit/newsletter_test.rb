require 'test_helper'

class NewsletterTest < ActiveSupport::TestCase
  should_have_many :articles
  should_require_attributes :published_on

  should_allow_values_for     :unsubscribe_url, 'http://example.com', '', nil
  should_not_allow_values_for :unsubscribe_url, 'example.com'

  context 'create' do
    setup do
      @newsletter = Factory.create(:newsletter, :published_on => Date.new(2009, 8, 5))
    end

    should 'adjust published_on to the first of the month' do
      @newsletter.published_on.day.should == 1
    end

    should 'include the year and the month in the slug' do
      @newsletter.slug.should == '200908'
    end

    should 'include the year and the month in the title' do
      @newsletter.title.should == 'Amani Newsletter - August 2009'
    end
  end

  context 'with an existing newsletter' do
    setup { Factory.create(:newsletter) }
    should_require_unique_attributes :published_on
  end

  should 'return the appropriate newsletter from find_by_slug!' do
    newsletter = Factory.create(:newsletter)
    Newsletter.find_by_slug!(newsletter.slug).should == newsletter
  end

  should "raise if can't find_by_slug!" do
    lambda { Newsletter.find_by_slug!('200910') }.should raise_error(ActiveRecord::RecordNotFound)
  end

  should "raise if invalid slug passed find_by_slug!" do
    lambda { Newsletter.find_by_slug!('20013') }.should raise_error(ActiveRecord::RecordNotFound)
  end
end
