class PopulateDoorFrames < ActiveRecord::Migration
  def self.up
    DoorFrame.create :name => 'Porte simple', :sections => 1, :preview_image_name => 'simple_door.png'
    DoorFrame.create :name => 'Porte double', :sections => 2, :preview_image_name => 'double_door.png'
    DoorFrame.create :name => 'Porte triple', :sections => 3, :preview_image_name => 'triple_door.png'
  end

  def self.down
    DoorFrame.delete_all
  end
end
