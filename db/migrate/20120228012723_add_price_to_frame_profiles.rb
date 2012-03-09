class AddPriceToFrameProfiles < ActiveRecord::Migration
  def self.up
    add_column :frame_profiles, :price, :float, :default => 0.0
  end

  def self.down
    remove_column :frame_profiles, :price
  end
end
