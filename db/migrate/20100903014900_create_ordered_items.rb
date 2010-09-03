class CreateOrderedItems < ActiveRecord::Migration
  def self.up
    create_table :ordered_items do |t|
      t.references :order
      t.references :item

      t.timestamps
    end
  end

  def self.down
    drop_table :ordered_items
  end
end
