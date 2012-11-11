module ApplicationHelper

  def ship_date_select(start_date)
    dates = []
    if start_date
      24.times do |i|
        dates << [l(start_date+i.month, :format => :month_only), start_date+i.month]
      end
    end
    dates
  end

  def show_title?
    true
  end
end
