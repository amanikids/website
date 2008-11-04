class PagesController < ApplicationController
  def index
    @sections = Section.ordered
  end
  def show
    @page = Page.find_by_param(params[:id])
  end
end
