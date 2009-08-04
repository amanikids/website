class SitemapsController < ApplicationController
  caches_page :show

  def show
    @root = Home.first
  end
end
