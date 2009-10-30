require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  should_have_many :photos

  context 'touch' do
    setup do
      @top    = Factory.create(:page)
      @middle = Factory.create(:page, :parent => @top)
      @bottom = Factory.create(:page, :parent => @middle)
    end

    context 'touching the bottom page' do
      setup do
        # I can't set updated_at in the Factory.create calls above, because
        # creating a child page automatically touches the parent, overwriting
        # whatever updated_at timestamp I would have set. So, sleep a little
        # bit. BUMMER.
        sleep 1
        @bottom.touch
      end

      should_change("the top page's timestamp") do
        @top.reload.updated_at
      end
    end
  end

  context 'without a parent' do
    setup { @content = Factory.create(:home) }

    should 'use default description when raw_description is blank' do
      @content.raw_description = ''
      assert_equal Content::DEFAULT_DESCRIPTION, @content.description
    end

    should 'use raw_description when set' do
      @content.raw_description = 'foo'
      assert_equal @content.raw_description, @content.description
    end

    should 'use default keywords when raw_keywords are blank' do
      @content.raw_keywords = ''
      assert_equal Content::DEFAULT_KEYWORDS, @content.keywords
    end

    should 'use raw_keywords when set' do
      @content.raw_keywords = 'foo'
      assert_equal @content.raw_keywords, @content.keywords
    end
  end

  context 'with a parent' do
    setup { @content = Factory.create(:page) }

    should 'use parent description when raw_description is blank' do
      @content.raw_description = ''
      @content.parent.expects(:description).returns('foo')
      assert_equal 'foo', @content.description
    end

    should 'use raw_description when set' do
      @content.raw_description = 'foo'
      assert_equal @content.raw_description, @content.description
    end

    should 'use parent keywords when raw_keywords are blank' do
      @content.raw_keywords = ''
      @content.parent.expects(:keywords).returns('foo')
      assert_equal 'foo', @content.keywords
    end

    should 'prepend raw_keywords to parent when set' do
      @content.raw_keywords = 'foo'
      assert_equal "#{@content.raw_keywords}, #{@content.parent.keywords}", @content.keywords
    end
  end
end