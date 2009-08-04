class Admin::CompositePagesController < Admin::ApplicationController
  before_filter :load_new_composite_page, :only => %w[new create]
  before_filter :load_composite_page,     :only => %w[edit update destroy]

  def create
    if @composite_page.save
      redirect_to @composite_page.continue_editing ? edit_admin_composite_page_path(@composite_page) : admin_root_path
    else
      render :action => 'new'
    end
  end

  def update
    if @composite_page.update_attributes(params[:composite_page])
      redirect_to @composite_page.continue_editing ? edit_admin_composite_page_path(@composite_page) : admin_root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @composite_page.destroy
    redirect_to admin_root_path
  end

  private

  def load_new_composite_page
    @composite_page = CompositePage.new(params[:composite_page])
  end

  def load_composite_page
    @composite_page = CompositePage.find(params[:id])
  end
end
