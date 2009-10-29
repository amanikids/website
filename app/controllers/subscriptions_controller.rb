class SubscriptionsController < ApplicationController
  before_filter :build_subscription

  def create
    if @subscription.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      render :action => 'new'
    end
  end

  private

  def build_subscription
    @subscription = Subscription.new(params[:subscription])
  end
end
