# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def rescue_action_in_public(exception)
    if response_code_for_rescue(exception) == :not_found
      render :template => 'exceptions/not_found', :status => :not_found
    else
      super
    end
  end
end
