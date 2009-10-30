require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  should_belong_to :content

  context 'with existing content' do
    setup { @content = Factory.create(:page, :updated_at => 3.hours.ago) }

    context 'creating a photo' do
      setup { Factory.create(:photo, :content => @content) }

      should_change("the content's timestamp") do
        @content.reload.updated_at
      end
    end
  end
end
