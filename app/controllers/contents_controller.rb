class ContentsController < ApplicationController
  caches_page :index, :show

  def index
    respond_to do |format|
      format.html
      format.atom { @contents = Content.all :order => 'updated_at DESC' }
    end
  end

  def show
    @content = Content.find_by_slug(params[:slugs].last) || raise(ActiveRecord::RecordNotFound)
  end
end
