class PagesController < ApplicationController
  def index
    @sections = Section.ordered
  end

  def show
    if params[:parent_id]
      @parent_page = Page.find_by_param(params[:parent_id])
      @page        = @parent_page.children.find_by_param(params[:id])
    else
      @parent_page = Page.find_by_param(params[:id])
      @page        = @parent_page
    end
  end
end
