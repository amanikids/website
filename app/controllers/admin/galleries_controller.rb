class Admin::GalleriesController < Admin::ApplicationController
  def new
    @gallery = Gallery.new(params[:gallery])
  end

  def create
    @gallery = Gallery.new(params[:gallery])
    if @gallery.save
      redirect_to admin_sections_path
    else
      render :action => 'new'
    end
  end

  def edit
    @gallery = Gallery.find(params[:id])
  end

  def update
    @gallery = Gallery.find(params[:id])
    if @gallery.update_attributes(params[:gallery])
      redirect_to admin_sections_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy
    redirect_to admin_sections_path
  end
end
