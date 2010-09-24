class ChangeFulfillerToAccepter < ActiveRecord::Migration
  def self.up
    rename_column :orders, :fulfiller_id, :accepter_id
  end

  def self.down
    rename_column :orders, :accepter_id, :fulfiller_id
  end
end
