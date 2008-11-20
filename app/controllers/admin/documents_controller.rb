class Admin::DocumentsController < Admin::ApplicationController
  def create
    @document = Document.create!(params[:document])
    redirect_to admin_root_path
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to admin_root_path
  end
end
