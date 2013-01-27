class CreateManualLines < ActiveRecord::Migration
  def self.up
    create_table :manual_lines do |t|
      t.text :description
      t.integer :quantity
      t.float :unit_price

      t.timestamps
    end
  end

  def self.down
    drop_table :manual_lines
  end
end
