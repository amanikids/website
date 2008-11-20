class ContentsController < ApplicationController
  caches_page :index, :show

  def index
    respond_to do |format|
      format.html { @home = Home.first }
      format.atom { @contents = Content.all(:order => 'updated_at DESC') }
    end
  end

  def show
    @content = Content.find_by_slugs(*params[:slugs])
  end
end
