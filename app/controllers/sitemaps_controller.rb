class SitemapsController < ApplicationController
  def show
    @root = Home.first
    setup_cache_headers_for(@root)
  end
end
