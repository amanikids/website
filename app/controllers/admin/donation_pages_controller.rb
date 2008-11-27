class Admin::DonationPagesController < Admin::ApplicationController
  before_filter :load_new_donation_page, :only => %w[new create]
  before_filter :load_donation_page,     :only => %w[edit update destroy]

  def create
    if @donation_page.save
      redirect_to @donation_page.continue_editing ? edit_admin_donation_page_path(@donation_page) : admin_root_path
    else
      render :action => 'new'
    end
  end

  def update
    if @donation_page.update_attributes(params[:donation_page])
      redirect_to @donation_page.continue_editing ? edit_admin_donation_page_path(@donation_page) : admin_root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @donation_page.destroy
    redirect_to admin_root_path
  end

  private

  def load_new_donation_page
    @donation_page = DonationPage.new(params[:donation_page])
  end

  def load_donation_page
    @donation_page = DonationPage.find(params[:id])
  end
end
