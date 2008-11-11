class ContentsController < ApplicationController
  def show
    @content = Content.find_by_slug(params[:slug]) || raise(ActiveRecord::RecordNotFound)
  end
end
