require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  should_route :get, '/', :action => 'index'
  should_route :get, '/this-is-my-page', :action => 'show', :id => 'this-is-my-page'
  should_route :get, '/this-is-my-parent/this-is-my-page', :action => 'show', :parent_id => 'this-is-my-parent', :id => 'this-is-my-page'

  context 'index' do
    setup { get :index }
    should_assign_to :sections
    should_render_template 'index'
  end

  context 'with an existing page' do
    setup { @page = Factory(:page) }

    context 'show' do
      setup { get :show, :id => @page.to_param }
      should_assign_to :page
      should_render_template 'show'
    end
  end
end
