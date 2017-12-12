class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml

  before_action :authenticate_admin!, only: [:delete_all]

  def index
    conditions = if params[:q].blank?
        "id > 0"
      else
        q = '%' + params[:q] + '%'
        ["name LIKE ? OR upc LIKE ? OR item_num LIKE ?", q,q,q ]
      end
    @products = Product.active.where(conditions).page(params[:page]).per(100)

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
    @product = Product.new(product_params)

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
      if @product.update_attributes(product_params)
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
      CSV.parse(params[:import][:file].read, :headers => :first_row) do |row|  #:col_sep => "\t"
        n=n+1 if Product.find_or_initialize_by(item_num: row["item_num"]).update_attributes(
          :name => row["name"],
          designer: row["designer"],
          upc: row["upc"], :price => row["price"],
          :min_qty => row["min_qty"] || 1,
          :start_date => row['start_date'].blank? ? Time.now : row['start_date'],
          coupon_1: row['coupon_1'], coupon_2: row['coupon_2'], coupon_3: row['coupon_3'], coupon_4: row['coupon_4'], coupon_5: row['coupon_5'],
          coupon_price_1: row['coupon_price_1'], coupon_price_2: row['coupon_price_2'], coupon_price_3: row['coupon_price_3'], coupon_price_4: row['coupon_price_4'],
          coupon_price_5: row['coupon_price_5'])
      end
      flash[:notice]="CSV Import Successful,  #{n} records have been updated in the database."
    end
  end

  def delete_all
    redirect_to(products_path, notice: "Delete all orders first.") and return if OrderItem.exists?
    Product.delete_all
    redirect_to products_path, notice: "All products have been deleted."
  end

  def export_to_csv
    csv_string = CSV.generate do |csv|
      csv << ["id", "item_num", "name", "upc", "price", "created_at", "updated_at", "start_date", "min_qty", "deleted", "coupon_1", "coupon_2", "coupon_price_1", "coupon_price_2", "coupon_3", "coupon_4", "coupon_5", "coupon_price_3", "coupon_price_4", "coupon_price_5", "designer"]
      Product.find_each do |p|
        csv << [p.id,  p.item_num,  p.name,  p.upc,  p.price,  p.created_at,  p.updated_at,  p.start_date,  p.min_qty,  p.deleted,  p.coupon_1,  p.coupon_2,  p.coupon_price_1,  p.coupon_price_2,  p.coupon_3,  p.coupon_4,  p.coupon_5,  p.coupon_price_3,  p.coupon_price_4,  p.coupon_price_5,  p.designer]
      end
    end
    send_data csv_string, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=products.csv"
  end

private
  def product_params
    params.require(:product).permit!
  end
end
