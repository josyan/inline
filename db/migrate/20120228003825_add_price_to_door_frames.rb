class AddPriceToDoorFrames < ActiveRecord::Migration
  def self.up
    add_column :door_frames, :price, :float
  end

  def self.down
    remove_column :door_frames, :price
  end
end
