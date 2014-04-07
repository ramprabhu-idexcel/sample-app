class PostsController < ApplicationController  
def index
  if params[:search].present?
    @posts = sunspot_search.results    
  else    
    @posts = Post.page(params[:page]).per(5)
  end 
 
  respond_to do |format|
    format.html  # index.html.erb
    format.json  { render :json => @posts }
  end
end

def new
  @post = Post.new
 
  respond_to do |format|
    format.html  # new.html.erb
    format.json  { render :json => @post }
  end
end

def create
  @post = Post.new(params[:post])
 
  respond_to do |format|
    if @post.save
      format.html  { redirect_to(@post,:notice => 'Post was successfully created.') }
      format.json  { render :json => @post,:status => :created, :location => @post }
    else
      format.html  { render :action => "new" }
      format.json  { render :json => @post.errors,:status => :unprocessable_entity }
    end
  end
end

def show
  @post = Post.find(params[:id])
 
  respond_to do |format|
    format.html  # show.html.erb
    format.json  { render :json => @post }
  end
end

def edit
  @post = Post.find(params[:id])
end

def update
  @post = Post.find(params[:id])
 
  respond_to do |format|
    if @post.update_attributes(params[:post])
      format.html  { redirect_to(@post,
                    :notice => 'Post was successfully updated.') }
      format.json  { head :no_content }
    else
      format.html  { render :action => "edit" }
      format.json  { render :json => @post.errors,
                    :status => :unprocessable_entity }
    end
  end
end

def destroy
  @post = Post.find(params[:id])
  @post.destroy
 
  respond_to do |format|
    format.html { redirect_to posts_url }
    format.json { head :no_content }
  end
end

private

def sunspot_search
  Sunspot.search(Post) do
      fulltext params[:search]
      facet :user_id
      with :user_id, current_user.id
      with(:published_at).less_than(Time.now)    
      order_by :published_at, :desc
      paginate :page => params[:page], :per_page => 5
  end
end 

end
