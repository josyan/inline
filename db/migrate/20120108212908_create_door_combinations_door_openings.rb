class CreateDoorCombinationsDoorOpenings < ActiveRecord::Migration
  def self.up
    create_table :door_combinations_door_openings, :id => false do |t|
      t.integer :door_combination_id
      t.integer :door_opening_id
    end
  end

  def self.down
    drop_table :door_combinations_door_openings
  end
end
