class NewslettersController < ApplicationController
  def show
    @newsletter = Newsletter.find_by_slug!(params[:id])
  end
end