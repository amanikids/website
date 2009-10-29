class Admin::ApplicationController < ApplicationController
  before_filter :load_user
  before_filter :require_user

  protected

  def load_user
    @user_session = UserSession.find
    @current_user = @user_session && @user_session.record
  end

  def require_user
    redirect_to new_admin_user_session_path unless @current_user
  end
end
