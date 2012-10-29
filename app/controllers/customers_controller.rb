class CustomersController < ApplicationController
  # GET /customers
  # GET /customers.xml
  def index
    conditions = if params[:q].blank?
        "id > 0"
      else
        q = '%' + params[:q] + '%'
        ["ax_customer_number LIKE ? OR company_name LIKE ? OR zip LIKE ?", q,q,q ]
      end
    @customers = Customer.where(conditions).page(params[:page]).per(100)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @customers }
    end
  end

  # GET /customers/1
  # GET /customers/1.xml
  def show
    @customer = Customer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.xml
  def new
    @customer = Customer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
  end

  # POST /customers
  # POST /customers.xml
  def create
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.save
        format.html { redirect_to(@customer, :notice => 'Customer was successfully created.') }
        format.xml  { render :xml => @customer, :status => :created, :location => @customer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.xml
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to(@customer, :notice => 'Customer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.xml
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to(customers_url) }
      format.xml  { head :ok }
    end
  end

  def import
    if request.post?
      n=0
      CSV.parse(params[:import][:file].read, :headers => :first_row) do |row|  #:col_sep => "\t"
        @customer = Customer.find_or_initialize_by_ax_customer_number row['ax_customer_number']
        n=n+1 if @customer.update_attributes ax_customer_number: row['ax_customer_number'], company_name: row['company_name'], full_name: row['full_name'], customer_class: row['customer_class'], address: row['address'], city: row['city'], state: row['state'], zip: row['zip'], country: row['country'], phone: row['phone'], email: row[:email]
      end
      flash[:notice]="CSV Import Successful,  #{n} records have been updated in the database."
    end
  end

  def search
    field = params[:field].presence || "ax_customer_number"
    @customers = Customer.where(["#{field} LIKE ? ", "%#{params[:query]}%"]).limit(10)
    render json: {query: params[:query], suggestions: @customers.map {|e| "#{e.ax_customer_number} - #{e.company_name}"}, data: @customers}
  end
end
