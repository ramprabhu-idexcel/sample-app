class ProductsController < ApplicationController
   before_filter :authenticate_user!
   skip_before_filter :verify_authenticity_token,only:[:create,:update]

	def index
    @products = Product.page(params[:page]).per(10).order(sort_column + " " + sort_direction)         
    respond_to do |format|
      format.html # new.html.erb
      #format.json { render :json => @products }
      format.js
    end
  end

  def search 
    @search_items = Product.search(params[:search])
     @products = Kaminari.paginate_array(@search_items).page(params[:page]).per(10)
     respond_to do |format|    
       format.js  { render action: "index" }
    end
  end
 
  def datagrid
  end

  def sorting
   @direction = params[:direction]
   @sorting = true
   @products = Product.page(params[:page]).per(10).order(sort_column + " " + sort_direction)   
   respond_to do |format|    
       format.js  { render :action => "index" }
    end 
  end

  def new
    @product = Product.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @product }
    end
  end

  def create    
    product=params[:product]
    product.each do |pro|
      @product = Product.new(JSON.parse(pro))
      @product.save
    end
    @products = Product.page(params[:page]).per(10).order(sort_column + " " + sort_direction)        
    respond_to do |format|       
      format.js { render :action => "index"}
    end    
  end

  def edit
    @product = Product.find(params[:id])    
    respond_to do |format|
    format.html
    end
  end

  def update
    @product = Product.find(params[:id])    

  respond_to do |format|
    if @product.update_attributes(params[:product])
      format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
      format.json { respond_with_bip(@product) }
    else
      format.html { render :action => "edit" }
      format.json { respond_with_bip(@product) }
    end
  end
 end

  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @product }
    end
  end

  def destroy   
    @product = Product.find(params[:id])
    @product.destroy 
    @products = Product.page(params[:page]).per(10).order(sort_column + " " + sort_direction)   
    render :action => "index"    
  end

  def destroy_all_prod    
    ids=params["ids"].split(',')
    @product = Product.destroy_all(:id => ids)
    @products = Product.page(params[:page]).per(10).order(sort_column + " " + sort_direction)   
    render :action => "index"
  end

  private

  def sort_column
   Product.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
