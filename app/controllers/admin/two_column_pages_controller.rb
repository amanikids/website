class Admin::TwoColumnPagesController < Admin::ApplicationController
  before_filter :load_new_two_column_page, :only => %w[new create]
  before_filter :load_two_column_page,     :only => %w[edit update destroy]

  def create
    if @two_column_page.save
      redirect_to @two_column_page.continue_editing ? edit_admin_two_column_page_path(@two_column_page) : admin_root_path
    else
      render :action => 'new'
    end
  end

  def update
    if @two_column_page.update_attributes(params[:two_column_page])
      redirect_to @two_column_page.continue_editing ? edit_admin_two_column_page_path(@two_column_page) : admin_root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @two_column_page.destroy
    redirect_to admin_root_path
  end

  private

  def load_new_two_column_page
    @two_column_page = TwoColumnPage.new(params[:two_column_page])
  end

  def load_two_column_page
    @two_column_page = TwoColumnPage.find(params[:id])
  end
end
