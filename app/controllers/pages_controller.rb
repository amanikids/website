class PagesController < ApplicationController
  def index
    @sections = Section.ordered
  end

  def show
    if params[:parent_slug]
      @parent_page = Page.find_by_slug(params[:parent_slug]) || raise(ActiveRecord::RecordNotFound)
      @page        = @parent_page.children.find_by_slug(params[:slug]) || raise(ActiveRecord::RecordNotFound)
    else
      @parent_page = Page.find_by_slug(params[:slug]) || raise(ActiveRecord::RecordNotFound)
      @page        = @parent_page
    end
  end
end
