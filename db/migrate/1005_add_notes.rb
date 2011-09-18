class AddNotes < ActiveRecord::Migration
  def self.up
	add_column :quotations, :notes, :text
  end

  def self.down
  	remove_column :quotations, :notes
  end
end
