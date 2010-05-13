class UsersController < ApplicationController

  # render new.rhtml
  def new
    @user = User.new
    @page_title = "Create new user account"
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @page_title = "Create new user account"
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "User created."
    else
      flash[:error]  = "New account could not be created."
      render :action => 'new'
    end
  end
  
  def show
    @user = User.new
  end
end
