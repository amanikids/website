class Admin::PagesController < Admin::ApplicationController
  before_filter :load_new_page, :only => %w[new create]
  before_filter :load_page,     :only => %w[edit update destroy]

  def create
    if @page.save
      redirect_to @page.continue_editing ? edit_admin_page_path(@page) : admin_root_path
    else
      render :action => 'new'
    end
  end

  def update
    if @page.update_attributes(params[:page])
      redirect_to @page.continue_editing ? edit_admin_page_path(@page) : admin_root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @page.destroy
    redirect_to admin_root_path
  end

  private

  def load_new_page
    @page = Page.new(params[:page])
  end

  def load_page
    @page = Page.find(params[:id])
  end
end
