class Admin::SectionsController < Admin::ApplicationController
  def index
    @sections = Section.ordered
  end

  def new
    @section = Section.new(params[:section])
  end

  def create
    @section = Section.new(params[:section])
    if @section.save
      redirect_to admin_sections_path
    else
      render :action => 'new'
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(params[:section])
      redirect_to admin_sections_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    redirect_to admin_sections_path
  end
end
