class RemoveCostFromOrderedItem < ActiveRecord::Migration
  def self.up
    remove_column :ordered_items, :float
  end

  def self.down
    add_column :ordered_items, :cost, :float
  end
end
