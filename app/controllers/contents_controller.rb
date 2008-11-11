class ContentsController < ApplicationController
  def show
    @content = Content.find_by_slug(params[:slugs].last) || raise(ActiveRecord::RecordNotFound)
  end
end
