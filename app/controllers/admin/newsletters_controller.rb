class Admin::NewslettersController < Admin::ApplicationController
  before_filter :load_new_newsletter, :only => %w[new create]
  before_filter :load_newsletter,     :only => %w[edit update destroy]

  def create
    if @newsletter.save
      redirect_to @newsletter.continue_editing ? edit_admin_newsletter_path(@newsletter) : admin_root_path
    else
      render :action => 'new'
    end
  end

  def update
    if @newsletter.update_attributes(params[:newsletter])
      redirect_to @newsletter.continue_editing ? edit_admin_newsletter_path(@newsletter) : admin_root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @newsletter.destroy
    redirect_to admin_root_path
  end

  private

  def load_new_newsletter
    @newsletter = Newsletter.new(params[:newsletter])
  end

  def load_newsletter
    @newsletter = Newsletter.find(params[:id])
  end
end
