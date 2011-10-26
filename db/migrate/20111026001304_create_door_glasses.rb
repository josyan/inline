class CreateDoorGlasses < ActiveRecord::Migration
  def self.up
    create_table :door_glasses do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :door_glasses
  end
end
