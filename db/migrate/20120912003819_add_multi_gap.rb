class AddMultiGap < ActiveRecord::Migration
  def self.up
    rename_column :frame_profiles, :gap, :gap_slab
    add_column :frame_profiles, :gap_l, :float, :default => 0.0
    add_column :frame_profiles, :gap_lp, :float, :default => 0.0
    add_column :frame_profiles, :gap_slf, :float, :default => 0.0

    FrameProfile.all.each do |fp|
      fp.gap_l = fp.gap_slab
      fp.gap_lp = fp.gap_slab
      fp.gap_slf = fp.gap_slab
      fp.save
    end
  end

  def self.down
    remove_column :frame_profiles, :gap_slf
    remove_column :frame_profiles, :gap_lp
    remove_column :frame_profiles, :gap_l
    rename_column :frame_profiles, :gap_slab, :gap
  end
end
