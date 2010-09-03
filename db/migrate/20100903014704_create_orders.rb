class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :orderer_id
      t.integer :fulfiller_id
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
