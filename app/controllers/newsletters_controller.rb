class NewslettersController < ApplicationController
  caches_page :show

  def show
    @newsletter = Newsletter.find_by_slug!(params[:id])
  end
end