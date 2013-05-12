class ReportsController < ApplicationController
  # GET /reports
  # GET /reports.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.mobile 
    end
  end

  def pre_order_report
    @orders = OrderItem.all(include: :product, group: :product_id, select: "*, SUM(price * quantity) as sum, SUM(quantity) as total_quantity")
    csv_string = CSV.generate do |csv|
      csv << ["itemid", "name", "item launch month", "total qty", "total sales"]
      @orders.each do |o|
        csv << [o.product.item_num, o.product.name, o.product.start_date, o.total_quantity, o.sum]
      end
    end
    send_data csv_string, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=pre_order_report.csv"
  end

end
