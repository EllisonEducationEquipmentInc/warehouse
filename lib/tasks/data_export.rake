namespace :data_export do
  desc "export orders to xml"
  task :orders => :environment do
    File.open("#{Rails.root}/tradeshow_orders.xml", "w") {|file| file.write(Order.all(:include => [:order_items, :products]).to_xml :include => {:order_items => {:include => {:product => {:only => [:item_num]}}}}, :dasherize => false)}
    p "done"
  end
end