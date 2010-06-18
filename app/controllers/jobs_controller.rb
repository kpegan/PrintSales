class JobsController < ApplicationController
  
  # GET /jobs
  # GET /jobs.xml
  def index
    if params[:user_id].nil?
      case params[:status]
        when "requested"
          conditions = "printed_at is NULL"
        when "printed"
          conditions = "printed_at is not NULL and paid_at is NULL"
        when "paid"
          conditions = "paid_at is not NULL"
        else 
          conditions = ""
      end
      
      @jobs = Job.find :all, :conditions => conditions, :order => "paid_at, printed_at"
      
      @total = 0;
      for job in @jobs
        @total += job.discounted_total
      end
      
      @page_title = "Print jobs"
      @table_caption = ""
    else
      @user = User.find(params[:user_id])
      @jobs = @user.jobs.all
      @page_title = "Print jobs for " + @user.full_name  
      @table_caption = ""
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.xml
  def show
    @job = Job.find(params[:id])
    @page_title = "Print job for #{@job.user.full_name}"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.xml
  def new
    @user = User.find(params[:user_id])
    @job = @user.jobs.new
    @job.paper_price = current_paper_price
    @job.ink_price = current_ink_price
    @job.quantity = 1

    @page_title = "New print job for " + @user.full_name 

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
    
    @page_title = "Editing print job"
  end

  # POST /jobs
  # POST /jobs.xml
  def create
    @user = User.find(params[:user_id])
    @job = @user.jobs.build(params[:job])
    @job.paper_price = current_paper_price
    @job.ink_price = current_ink_price

    respond_to do |format|
      if @job.save
        flash[:notice] = 'Job was successfully created.'
        format.html { redirect_to(@job) }
        format.xml  { render :xml => @job, :status => :created, :location => @job }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.xml
  def update
    @job = Job.find(params[:id])
    case params[:status]
      when "requested"
        @job.status :requested
      when "printed"
        @job.status :printed
      when "paid"
        @job.status :paid
    end
    
    @job.save

    respond_to do |format|
      if @job.update_attributes(params[:job])
        flash[:notice] = 'Job was successfully updated.'
        format.html { redirect_to(@job) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /jobs/1
  # DELETE /jobs/1.xml
  def destroy
    @job = Job.find(params[:id])
    if current_user.is_an_admin? or @job.status != "paid"
      @job.destroy
    else
      flash[:error] = "Paid jobs can only be modified by an administrator."
    end
    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
    end
  end
  
  def pay
    #Pay selected jobs
    @page_title = "Receipt"
    if params[:job_ids].any?
      @user = User.find params[:user_id]
      @jobs = Job.find params[:job_ids] 
      
      @total = 0
      for job in @jobs
        job.status params[:submit] == "Print selected" ? :printed : :paid
        job.save
        @total += job.discounted_total
      end
    else
      flash[:error] = "You didn't select any print jobs."
    end
    if params[:submit] == "Pay selected"
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @jobs }
      end
    else
      redirect_to @user
    end
  end

  def print
    @job = Job.find(params[:id])
    
    @job.status :printed
    @job.save
    
    respond_to do |format|
      format.html { redirect_to(@job) }
      format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
    end
  end
  
  def void_printed
    @job = Job.find(params[:id])
    respond_to do |format|
      if @job.update_attributes(:printed_at => nil )
        flash[:notice] = 'Job is now set to requested.'
        format.html { redirect_to(@job) }
        format.xml  { head :ok }
      else
        flash[:error] = 'An error occured. Job could not be set to printed.'
        format.html { redirect_to(@job) }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }       
      end
    end
  end

  def void_payment
    @job = Job.find(params[:id])
    respond_to do |format|
      if @job.update_attributes(:paid_at => nil )
        flash[:notice] = 'Job is now set to printed.'
        format.html { redirect_to(@job) }
        format.xml  { head :ok }
      else
        flash[:error] = 'An error occured. Job could not be set to printed.'
        format.html { redirect_to(@job) }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }       
      end
    end
  end 
  
  
  
end
