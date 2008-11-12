class Admin::HomesController < Admin::ApplicationController
  before_filter :load_home

  def update
    if @home.update_attributes(params[:home])
      redirect_to @home.continue_editing ? edit_admin_home_path(@home) : admin_root_path
    else
      render :action => 'edit'
    end
  end

  private

  def load_home
    @home = Home.find(params[:id])
  end
end