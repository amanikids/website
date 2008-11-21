class SharesController < ApplicationController
  before_filter :load_new_share
  session :on

  def create
    if @share.save
      redirect_to content_path(@share.content.slugs)
    else
      render :action => 'new'
    end
  end

  private

  def load_new_share
    @content = Content.find(params[:content_id])
    @share = @content.shares.build(params[:share])
  end
end
