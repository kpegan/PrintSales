class UsersController < ApplicationController

  before_filter :login_required, :only => [ :index, :show, :edit, :update, :destroy ]

  def index
    #have to be logged in to see user list
    
    @users = User.all
    @page_title = "Users"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  # GET /users/1
  # GET /users/1.xml
  def show    
    @user = User.find(params[:id])
    #@unpaid_jobs = @user.jobs.find(:all, :conditions => "paid IS NULL")
    #@total_bill = 0;
    #for job in @unpaid_jobs
    #  @total_bill += job.discounted_total
    #end
    
    @page_title = @user.full_name #+ " [" + @user.role.name + "]"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # render new.rhtml
  def new
    @user = User.new
    @page_title = "Create new user account"
  end
  
  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @centered = "centered"
    @page_title = "Editing " + @user.full_name
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user]) 
    
    @user.role_id = 5 unless logged_in? and current_user.is_an_admin?
    @user.graduation = nil
    @user.first_name = "Tutti Fruiti"
    
    @page_title = "Create new user account"
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      
      #changes current_user to new user, 
      #self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "User created."
    else
      flash[:error]  = "New account could not be created."
      render :action => 'new'
    end
  end
  
  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    
    @user.graduation = nil

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
end
