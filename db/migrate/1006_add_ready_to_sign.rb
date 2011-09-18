class AddReadyToSign < ActiveRecord::Migration
  def self.up
    add_column :quotations, :ready_to_sign, :boolean,  :default => false
  end

  def self.down
  	remove_column :quotations, :ready_to_sign
  end
end
