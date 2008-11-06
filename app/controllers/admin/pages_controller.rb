class Admin::PagesController < Admin::ApplicationController
  def new
    @page = Page.new(params[:page])
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to admin_sections_path
    else
      render :action => 'new'
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to @page.continue_editing ? edit_admin_page_path(@page) : admin_sections_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to admin_sections_path
  end
end
