class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.xml
  def index
    #@search = Search.new(:order, :q => "orders.id LIKE ? OR orders.email LIKE ? OR orders.business LIKE ?" )
    #@search.q = '%' + params[:q] + '%' unless params[:q].blank?
    #@orders = @search.search.order(:order => "created_at DESC").page(params[:page]).per(500)
    if params[:q].present?
      @orders = Order.where(["orders.email LIKE ? OR orders.business LIKE ? OR orders.customer_number LIKE ?",  '%' + params[:q]+ '%', '%' + params[:q] + '%', '%' + params[:q] + '%']).page(params[:page]).per(500)
    else
      @orders = Order.order("created_at desc").page(params[:page]).per(500)
    end

    if ['asc', 'desc'].include? params[:sort]
      @orders = @orders.reorder("customer_number #{params[:sort]}")
    end
    session[:coupon] = nil

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])
    @title = "#{order_name} Receipt"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    session[:coupon] = nil
    @order = Order.new(:sub_total => 0.0, :payment_method => nil, employee_number: current_user.employee_number, :sales_tax => nil, :total => nil)
    @editable = true
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    session[:coupon] = @order.coupon_code
    @editable = true
    respond_to do |format|
      format.html
    end
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(order_params)
    @order.coupon_code = session[:coupon] if session[:coupon].present?
    @order.employee_number ||= current_user.employee_number
    process_file if params[:order][:file].present?
    calculate_total
    respond_to do |format|
      if params[:order][:file].blank? && @order.save
        format.html { redirect_to(@order, :notice => 'Order was successfully created.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        @editable = true
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  def email
    @order = Order.find(params[:id])
    if @order.email.present?
      UserMailer.order_confirmation(@order).deliver
      redirect_to(@order, :notice => 'Order was emailed successfully.')
    else
      redirect_to(edit_order_path(@order), :error => 'Order has no email.')
    end
  end
  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])
    @order.order_items = []
    @order.coupon_code = session[:coupon] if session[:coupon].present?
    session[:coupon] = @order.coupon_code
    @order.update_attributes order_params
    #@order.order_item_ids = params[:order][:order_item_attributes].keys.map {|a| a.to_i}
    calculate_total
    respond_to do |format|
      if @order.save
        session[:coupon] = nil
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end

  def add_item
    @order = if params[:id].present?
      Order.find(params[:id])
    else
      Order.new
    end
    @editable = true
    @product = Product.active.find_by_upc(params[:upc]) || Product.active.find_by_item_num(params[:upc])
    if @product
      @order_item = @product.order_items.build(:price => @product.price(session[:coupon]), :quantity => @product.min_qty, ship_month: @product.start_date_or_today)
      @order_item = @product.order_items.find_or_initialize_by(order_id: params[:id])
      @order_item.quantity = @product.min_qty if @order_item.new_record?
      @order_item.price = @product.price(session[:coupon])
      @order_item.order_id = @order.id
    end
    render :update
  end

  def add_coupon
    session[:coupon] = params[:coupon]
  end

  def export_to_csv
    @orders = OrderItem.includes([:order, :product])
    csv_string = CSV.generate do |csv|
      csv << ["itemid", "qty", "unit", "unitprice", "discount", "discount%", "item_total", "order_sub_total", "order_total", "order_sales_tax", "customer_number", "order_id", "ship_date", "employee_number", "source_code", "sales_origin", "notes", "email",  "business", "contact", "phone", "address", "city", "state", "zip", "country", "payment_method", "tax_exempt", "tax_exempt_number",  "start_date",  "created_at", "updated_at",  "start_date_month", "start_date_year",  "full_name", "ship_date_month", "ship_date_year", "discount_amount"]
      @orders.each do |o|
        csv << [o.product.item_num, o.quantity, "EA", o.product.try(:price), o.product.price - o.price, "", o.item_total, o.order.sub_total, o.order.total, o.order.sales_tax, o.order.customer_number, "#{order_prefix}#{o.order_id}",  o.ship_month, o.order.employee_number, o.order.coupon_code, "", o.order.notes, o.order.email, o.order.business, o.order.contact, o.order.phone, o.order.address, o.order.city, o.order.state, o.order.zip_code, o.order.country, o.order.payment_method, o.order.tax_exempt, o.order.tax_exempt_number,  o.product.start_date,  o.created_at, o.updated_at,  o.product.start_date.try(:strftime, "%B"), o.product.start_date.try(:strftime, "%Y"),  o.order.full_name,   o.ship_month.try(:strftime, "%B"), o.ship_month.try(:strftime, "%Y"), o.order.discount_amount]
      end
    end
    send_data csv_string, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=orders.csv"
  end

private

  def calculate_total
    @order.sub_total = @order.order_items.inject(0) {|sum, order_item| sum += order_item.item_total}
    @order.sales_tax = @order.tax_exempt? ? 0.0 : @order.sub_total * Order::SALES_TAX
    @order.total = @order.sales_tax + @order.sub_total
  end

  def process_file
    flash[:error] = ''.html_safe
    CSV.parse(params[:order][:file].read, :headers => :first_row) do |row|  #:col_sep => "\t"
      p = Product.find_by_item_num(row["item_num"])
      flash[:error] += "#{row['item_num']} was not found<br>".html_safe unless p
      session[:coupon] = row["coupon_code"]
      @order.order_items.build product: p, quantity: row["qty"], price: p.price(row["coupon_code"]), ship_month: p.start_date_or_today if p
    end
  end

private
  def order_params
    params.require(:order).permit!
  end
end
