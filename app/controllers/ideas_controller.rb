class IdeasController < ApplicationController
  require 'csv'
  before_filter :authenticate_user!
  
  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = Idea.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @ideas }
    end
  end

  def all_idea
    prawnto :prawn => { :top_margin => 75 }
    @idea_rows=[]    
    @idea_rows << [("Name"), ("Description"),("CreatedBy")]
    Idea.get_all.each do |item|
       @idea_rows << [item.name,item.description,item.user.first_name+item.user.last_name]
    end
    respond_to do |format|
     format.html
     format.pdf { render :layout => false }
    end

    
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @idea = Idea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @idea }
    end
  end

  # GET /ideas/new
  # GET /ideas/new.json
  def new
    @idea = Idea.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @idea }
    end
  end

  # GET /ideas/1/edit
  def edit
    @idea = Idea.find(params[:id])    
    respond_to do |format|
    format.html
    end
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = Idea.new(params[:idea])

    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, :notice => 'Idea was successfully created.' }
        format.json { render :json => @idea, :status => :created, :location => @idea }
      else
        format.html { render :action => "new" }
        format.json { render :json => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ideas/1
  # PUT /ideas/1.json
  def update
    @idea = Idea.find(params[:id])

    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        format.html { redirect_to @idea, :notice => 'Idea was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to ideas_url }
      format.json { head :no_content }
    end
  end

  def uploads
    @receivables = Receivable.page(params[:page]).per(10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @posts }
    end
    
  end

  def create_upload   
    import_data = []
    unless params[:clear]   
    file=params[:dump][:file] rescue nil
    FCSV.new(file.tempfile, :headers => true).each do |row|            
      csv_content = Receivable.new(:account_no=>row[0],:name=>row[1],
                      :invoice =>row[2],:original_date=>row[3],
                      :amount=>row[4],:due_date=>row[5])   
      raise csv_content.errors.full_messages.join(", ") unless csv_content.valid?
      import_data << csv_content
    end
    Receivable.import(import_data,{:timestamp => false, :validate => false})  
    flash.now[:message]="CSV Import Successful,  new records added"
    else
    ActiveRecord::Base.connection.execute("truncate table receivables")  
    end
    redirect_to :action => 'uploads'    
  end

end
