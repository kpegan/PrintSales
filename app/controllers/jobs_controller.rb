class JobsController < ApplicationController
  before_filter :login_required
  
  # GET /jobs
  # GET /jobs.xml
  def index
    if params[:user_id].nil?
      @jobs = Job.find :all, :order => "paid_at, printed_at"
      @total_unpaid = 0;
      for job in @jobs
        @total_unpaid += job.discounted_total if job.paid.nil?
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
    @page_title = "'#{@job.file}' for #{@job.user.full_name}"

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
  
  def pay
    #Pay selected jobs

=begin
    @job = Job.find(params[:id])
    respond_to do |format|
      if @job.update_attributes(:paid => Time.now() )
        flash[:notice] = 'Job is now paid.'
        format.html { redirect_to(@job) }
        format.xml  { head :ok }
      else
        flash[:error] = 'An error occured. Job could not be set to paid.'
        format.html { redirect_to(@job) }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }       
      end
    end
=end
  end

  def print
    @job = Job.find(params[:id])
    respond_to do |format|
      if @job.update_attributes(:printed_at => Time.now() )
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
  
  # DELETE /jobs/1
  # DELETE /jobs/1.xml
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
    end
  end
end
