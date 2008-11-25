class Admin::PhotosController < Admin::ApplicationController
  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      redirect_to edit_polymorphic_path([:admin, @photo.content])
    else
      render :partial => @photo
    end
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      redirect_to edit_polymorphic_path([:admin, @photo.content])
    else
      render :partial => @photo
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to edit_polymorphic_path([:admin, @photo.content])
  end
end
