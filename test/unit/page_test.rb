require 'test_helper'

class PageTest < ActiveSupport::TestCase
  should_require_attributes :title, :slug, :body
  should_allow_values_for :slug, 'this-is-a-good-slug'
  should_not_allow_values_for :slug, 'this has spaces', 'THIS HAS CAPITAL LETTERS', 'this.has?punctuation'

  context 'next_page' do
    setup { @home = Factory(:home) }

    context 'under a section' do
      setup do
        @section = Factory(:section, :parent => @home)
        @page    = Factory(:page, :parent => @section)
      end

      should 'return nil as next_page' do
        assert_nil @page.next_page
      end

      context 'with a next page in the same section' do
        setup { @next_page = Factory(:page, :parent => @section) }
        should 'return lower_item as next_page' do
          assert_equal @next_page, @page.next_page
        end
      end

      context 'with a next section having a page' do
        setup do
          @next_section = Factory(:section, :parent => @home)
          @next_page = Factory(:page, :parent => @next_section)
        end
        should 'return that page as next_page' do
          assert_equal @next_page, @page.next_page
        end

        context 'or two, sorted' do
          setup do
            @actual_next_page = Factory(:page, :parent => @next_section)
            @actual_next_page.move_higher
          end
          should 'really return the first page as next_page' do
            assert_equal @actual_next_page, @page.next_page
          end
        end
      end

      context 'when the next "section" is not a section' do
        setup do
          @next_section = Factory(:page, :parent => @home)
          @next_page    = Factory(:page, :parent => @next_section)
        end
        should 'return nil as next_page' do
          assert_nil @page.next_page
        end
      end
    end
  end

  context 'show children at' do
    setup { @page = Factory(:page) }

    should 'be false' do
      assert !@page.show_children_at?(:top)
    end

    context 'when the page has children' do
      setup { @child = Factory(:page, :parent => @page) }
      should 'be true' do
        assert @page.show_children_at?(:top)
      end

      context 'but show_child_links_at is bottom' do
        setup { @page.update_attribute(:show_child_links_at, 'bottom') }
        should 'be false' do
          assert !@page.show_children_at?(:top)
        end
      end
    end
  end
end
