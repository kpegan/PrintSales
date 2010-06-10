# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  include AuthenticatedSystem
 
  before_filter :login_required
    
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
  protected
    def authorized?
      unless authorized = logged_in? && current_user.is_an_admin_or_staff?
        flash[:error] = "You do not have access to that area."
      end
      authorized
    end
  
  def current_paper_price
    1.5
  end
  
  def current_ink_price
    2
  end
  
end
