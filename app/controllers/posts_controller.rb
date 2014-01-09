class PostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :page_expiry!,:only => [:create,:update,:destroy]
  caches_action :index

  http_basic_authenticate_with :name => "ram", :password => "ram123", :except => [:index, :show]
  # GET /posts
  # GET /posts.json
  def index        
    #time=Time.now
    #data = Array.new
    #db = ActiveRecord::Base.connection.raw_connection
    #@find_post = db.query("CALL GetAllPosts();")
    #@find_post.each {|r| data << r}
    #@find_post = Post.find_by_sql( 'CALL GetAllPosts()' )
    #@posts = Post.all
    #@posts = Kaminari.paginate_array(data).page(params[:page]).per(10)
    #ActiveRecord::Base.connection.reconnect!
    #diff_seconds = (Time.now - time).round    
    @posts=Post.page(params[:page]).per(10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    if(@post.user.id==current_user.id)
      render :action => 'edit'
    else
      redirect_to posts_path, :notice => "You cannot edit others post"
    end
  end

  # POST /posts
  # POST /posts.json
  def create     
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, :notice => 'Post was successfully created.' }
        format.json { render :json => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update    
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, :notice => 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    if(@post.user.id==current_user.id)
      @post.destroy
    else
      notice = "You cannot delete others post"
    end

    respond_to do |format|
      format.html { redirect_to posts_url,:notice => notice }
      format.json { head :no_content }
    end
  end

  def page_expiry!
    expire_page :action => :index		
  end	
end
