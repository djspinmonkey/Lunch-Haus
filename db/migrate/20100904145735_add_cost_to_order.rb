class AddCostToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :cost, :float
  end

  def self.down
    remove_column :orders, :cost
  end
end
