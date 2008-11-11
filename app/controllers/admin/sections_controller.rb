class Admin::SectionsController < Admin::ApplicationController
  before_filter :load_new_section, :only => %w[new create]
  before_filter :load_section,     :only => %w[edit update destroy]

  def create
    if @section.save
      redirect_to admin_root_path
    else
      render :action => 'new'
    end
  end

  def update
    if @section.update_attributes(params[:section])
      redirect_to admin_root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @section.destroy
    redirect_to admin_root_path
  end

  private

  def load_new_section
    @section = Section.new(params[:section])
  end

  def load_section
    @section = Section.find(params[:id])
  end
end
