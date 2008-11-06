class PagesController < ApplicationController
  def index
    @sections = Section.ordered
  end

  def show
    page = Content.find_by_slug(params[:slug]) || raise(ActiveRecord::RecordNotFound)
    @parent_page, @page = page.parent_and_child
  end
end
