class CorrectRestaurantSpelling < ActiveRecord::Migration
  def self.up
    rename_column :items, :restaraunt_id, :restaurant_id
  end

  def self.down
    rename_column :items, :restaurant_id, :restaraunt_id
  end
end
