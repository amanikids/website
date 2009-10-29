require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  should_route :get,  '/subscriptions/new', :action => 'new'
  should_route :post, '/subscriptions',     :action => 'create'

  context 'new' do
    setup { get 'new' }
    should_assign_to :subscription
    should_render_template 'new'
  end

  context 'create' do
    context 'valid' do
      setup { post :create, :subscription => Factory.attributes_for(:subscription) }
      should_change('Subscription.count') { Subscription.count }
      should_redirect_to('the homepage') { root_path }
    end

    context 'invalid' do
      setup { post :create }
      should_not_change('Subscription.count') { Subscription.count }
      should_render_template 'new'
    end
  end
end