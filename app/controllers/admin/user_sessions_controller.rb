class Admin::UserSessionsController < Admin::ApplicationController
  skip_before_filter :require_user, :only => %w[new create]

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to admin_root_path
    else
      render :action => :new
    end
  end

  def destroy
    @user_session.destroy
    redirect_to admin_root_path
  end
end
