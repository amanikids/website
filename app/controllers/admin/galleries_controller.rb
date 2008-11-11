class Admin::GalleriesController < Admin::ApplicationController
  before_filter :load_new_gallery, :only => %w[new create]
  before_filter :load_gallery,     :only => %w[edit update destroy]

  def create
    if @gallery.save
      redirect_to admin_root_path
    else
      render :action => 'new'
    end
  end

  def update
    if @gallery.update_attributes(params[:gallery])
      redirect_to admin_root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @gallery.destroy
    redirect_to admin_root_path
  end

  private

  def load_new_gallery
    @gallery = Gallery.new(params[:gallery])
  end

  def load_gallery
    @gallery = Gallery.find(params[:id])
  end
end
