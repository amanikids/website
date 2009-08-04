class Admin::DocumentsController < Admin::ApplicationController
  def index
    @documents = Document.all
  end

  def create
    @document = Document.create!(params[:document])
    redirect_to admin_documents_path
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to admin_documents_path
  end
end
