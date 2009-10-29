require 'test_helper'

class SharesControllerTest < ActionController::TestCase
  should_route :get,  '/contents/42/shares/new', :action => 'new',    :content_id => 42
  should_route :post, '/contents/42/shares',     :action => 'create', :content_id => 42

  context 'with an existing Page' do
    setup { @content = Factory(:page) }

    context 'new' do
      setup { get :new, :content_id => @content.id }
      should_assign_to :share
      should_render_template 'new'
    end

    context 'create valid' do
      setup { post :create, :content_id => @content.id, :share => Factory.attributes_for(:share) }
      should_change('Share.count', :by => 1) { Share.count }
      should_redirect_to('the shared page') { content_path(assigns(:share).content.slugs) }
    end

    context 'create invalid' do
      setup { post :create, :content_id => @content.id }
      should_not_change('Share.count') { Share.count }
      should_render_template 'new'
    end
  end
end
