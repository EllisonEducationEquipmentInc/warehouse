class AddDesignerToProducts < ActiveRecord::Migration
  def change
    add_column :products, :designer, :text
  end
end
