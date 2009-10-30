class ContentsController < ApplicationController
  before_filter :setup_cache_headers

  def index
    respond_to do |format|
      format.html { @content = Home.first }
      format.atom { @contents = Content.all(:order => 'updated_at DESC') }
    end
  end

  def show
    @content = Content.find_by_slugs(*params[:slugs])
  end

  private

  def setup_cache_headers
    setup_cache_headers_for(Home.first)
  end
end
