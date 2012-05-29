class AddDimensionsToFrameProfiles < ActiveRecord::Migration
  def self.up
    add_column :frame_profiles, :width, :float, :default => 0.0
    add_column :frame_profiles, :separator_width, :float, :default => 0.0
    add_column :frame_profiles, :gap, :float, :default => 0.0
  end

  def self.down
    remove_column :frame_profiles, :width
    remove_column :frame_profiles, :separator_width
    remove_column :frame_profiles, :gap
  end
end
