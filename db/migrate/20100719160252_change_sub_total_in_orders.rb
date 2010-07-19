class ChangeSubTotalInOrders < ActiveRecord::Migration
  def self.up
		change_column :orders, :sub_total, :decimal, :precision => 12, :scale => 2
  end

  def self.down
  end
end
