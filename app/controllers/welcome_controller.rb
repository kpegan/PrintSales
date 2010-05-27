class WelcomeController < ApplicationController
  skip_before_filter :login_required
  
  def index
    @page_title = "Welcome"
  end
end
