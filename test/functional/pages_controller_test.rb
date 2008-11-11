require 'test_helper'

class ContentsControllerTest < ActionController::TestCase
  should_route :get, '/', :action => 'index'
  should_route :get, '/this-is-my-page', :action => 'show', :slug => 'this-is-my-page'

  context 'with an existing page' do
    setup { @page = Factory(:page) }

    context 'show' do
      setup { get :show, :slug => @page.slug }
      should_assign_to :content
      should_render_template 'show'
    end
  end
end
