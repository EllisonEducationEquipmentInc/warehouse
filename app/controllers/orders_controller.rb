class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.xml
  def index
    @search = Search.new(:order, :q => "orders.id LIKE ? OR orders.email LIKE ? OR orders.business LIKE ?" )
    @search.q = '%' + params[:q] + '%' unless params[:q].blank?
    @orders = @search.search.order(:order => "created_at DESC").page(params[:page]).per(500)

    respond_to do |format|
      format.html # index.html.erb
      format.mobile 
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
      format.mobile 
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @order = Order.new(:sub_total => 0.0, :payment_method => warehouse? ? "Credit Card" : nil, :sales_tax => warehouse? ? 0.0 : nil, :total => warehouse? ? 0.0 : nil)
    @editable = true
    respond_to do |format|
      format.html # new.html.erb
      format.mobile 
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    @editable = true
    respond_to do |format|
      format.html 
      format.mobile 
    end
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])
    calculate_total
    respond_to do |format|
      if @order.save
        format.html { redirect_to(@order, :notice => 'Order was successfully created.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        @editable = true
        format.html { render :action => "new" }
        format.mobile {@order.save(false); redirect_to(@order)}
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])
    @order.attributes = params[:order]
    @order.order_item_ids = params[:order][:order_item_attributes].keys.map {|a| a.to_i}
    calculate_total
    respond_to do |format|
      if @order.save
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
    @editable = true
    @product = Product.active.find_by_upc(params[:upc]) || Product.active.find_by_item_num(params[:upc])
    render :update do |page|
      if @product
        if params[:id].blank?
          @order_item = @product.order_items.build(:price => @product.price, :quantity => tradeshow? ? @product.min_qty : 1, ship_month: @product.start_date)
        else
          @order_item = @product.order_items.find_or_initialize_by_order_id(params[:id])
          @order_item.quantity = @product.min_qty if tradeshow? && @order_item.new_record?
          @order_item.update_attributes :price => @product.price
        end
        page << "$('add_item_form').reset()"
        page << "$('order_sub_total').value = parseFloat($('order_sub_total').value) + #{@product.price}"
        page << " if ($$('#order_item_#{@order_item.product.id_with_start_date}').length < 1) {"
          page.insert_html :top, :products, :partial => 'order_item', :object => @order_item
        page << "} else {"
          page << "var qty = $('order_item_#{@order_item.product.id_with_start_date}').down('#order_order_item_attributes_#{@order_item.product.id_with_start_date}_quantity').value * 1"
          page << "$('order_item_#{@order_item.product.id_with_start_date}').down('#order_order_item_attributes_#{@order_item.product.id_with_start_date}_quantity').value = qty + 1"
        page << "}"  
        page.visual_effect :highlight, "order_item_#{@order_item.product.id_with_start_date}"
        page << "update_totals()"
      else
        page << "Sound.play('/error.mp3',{replace:false});"
        page << "product_not_found()"
      end
      page << "Form.Element.focus($('upc'));" unless params[:dup].present?
    end
  end
  
  def export_to_csv
    @orders = OrderItem.all(:include => [:order, :product])
    csv_string = CSV.generate do |csv|
      csv << ["itemid", "qty", "unit", "unitprice", "discount", "discountpercent", "item_total", "order_sub_total", "order_total", "order_sales_tax", "customer_number", "order_id", "ship_date", "employee_number", "source_code", "sales_origin", "notes", "email",  "business", "contact", "phone", "address", "city", "state", "zip", "country", "payment_method", "tax_exempt", "tax_exempt_number",  "start_date",  "created_at", "updated_at",  "start_date_month", "start_date_year",  "full_name", "ship_date_month", "ship_date_year"]
      @orders.each do |o|
        csv << [o.product.item_num, o.quantity, "EA", o.price, "", "", o.item_total, o.order.sub_total, o.order.total, o.order.sales_tax, o.order.customer_number, "#{order_prefix}#{o.order_id}",  o.ship_month, o.order.employee_number, o.order.coupon_code, "", o.order.notes, o.order.email, o.order.business, o.order.contact, o.order.phone, o.order.address, o.order.city, o.order.state, o.order.zip_code, o.order.country, o.order.payment_method, o.order.tax_exempt, o.order.tax_exempt_number,  o.product.start_date,  o.created_at, o.updated_at,  o.product.start_date.try(:strftime, "%B"), o.product.start_date.try(:strftime, "%Y"),  o.order.full_name,   o.ship_month.try(:strftime, "%B"), o.ship_month.try(:strftime, "%Y")]
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
end
