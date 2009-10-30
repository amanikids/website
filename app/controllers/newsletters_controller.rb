class NewslettersController < ApplicationController
  def show
    @newsletter = Newsletter.find_by_slug!(params[:id])
    setup_cache_headers_for(@newsletter)
  end
end