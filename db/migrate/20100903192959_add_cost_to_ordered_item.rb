class AddCostToOrderedItem < ActiveRecord::Migration
  def self.up
    add_column :ordered_items, :cost, :float
  end

  def self.down
    remove_column :ordered_items, :cost
  end
end
