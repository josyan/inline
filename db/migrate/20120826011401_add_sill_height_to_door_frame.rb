class AddSillHeightToDoorFrame < ActiveRecord::Migration
  def self.up
    add_column :frame_profiles, :sill, :float, :default => 0
  end

  def self.down
    remove_column :frame_profiles, :sill
  end
end
