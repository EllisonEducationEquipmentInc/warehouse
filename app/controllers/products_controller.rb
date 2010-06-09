class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  def index
		conditions = if params[:q].blank?
				"id > 0"
			else
				q = '%' + params[:q] + '%'
				["name LIKE ? OR upc LIKE ? OR item_num LIKE ?", q,q,q ]
			end
    @products = Product.all(:conditions => conditions).paginate :page => params[:page], :per_page => 100

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end

	def import
    if request.post?
      n=0
      FasterCSV.parse(params[:import][:file], :headers => :first_row) do |row|  #:col_sep => "\t"
				n=n+1 unless Product.create(:name => row["name"], :upc => row["upc"], :item_num => row["item_num"], :price => row["price"], :min_qty => row["min_qty"], :start_date => row['start_date']).new_record?
      end
      flash[:notice]="CSV Import Successful,  #{n} records have been updated in the database."
    end
  end
end
