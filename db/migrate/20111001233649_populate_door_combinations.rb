class PopulateDoorCombinations < ActiveRecord::Migration
  def self.up
    DoorCombination.create :name => 'Porte simple', :sections => 'SL', :preview_image_name => 'SL.png', :door_frame_id => 1
    DoorCombination.create :name => 'Porte simple avec L gauche', :sections => 'L;SL', :preview_image_name => 'L_SL.png', :door_frame_id => 1
    DoorCombination.create :name => 'Porte simple avec L droit', :sections => 'SL;L', :preview_image_name => 'SL_L.png', :door_frame_id => 1
    DoorCombination.create :name => 'Porte simple avec deux L', :sections => 'L;SL;L', :preview_image_name => 'L_SL_L.png', :door_frame_id => 1
    DoorCombination.create :name => 'Porte simple avec LP gauche', :sections => 'LP;SL', :preview_image_name => 'LP_SL.png', :door_frame_id => 1
    DoorCombination.create :name => 'Porte simple avec LP droit', :sections => 'SL;LP', :preview_image_name => 'SL_LP.png', :door_frame_id => 1
    DoorCombination.create :name => 'Porte simple avec deux LP', :sections => 'LP;SL;LP', :preview_image_name => 'LP_SL_LP.png', :door_frame_id => 1
    DoorCombination.create :name => 'Porte simple avec SLF gauche', :sections => 'SLF;SL', :preview_image_name => 'SLF_SL.png', :door_frame_id => 1
    DoorCombination.create :name => 'Porte simple avec SLF droit', :sections => 'SL;SLF', :preview_image_name => 'SL_SLF.png', :door_frame_id => 1
    DoorCombination.create :name => 'Porte simple avec deux SLF', :sections => 'SLF;SL;SLF', :preview_image_name => 'SLF_SL_SLF.png', :door_frame_id => 1
    DoorCombination.create :name => 'Porte simple avec SLO gauche', :sections => 'SLO;SL', :preview_image_name => 'SLF_SL.png', :door_frame_id => 1
    DoorCombination.create :name => 'Porte simple avec SLO droit', :sections => 'SL;SLO', :preview_image_name => 'SL_SLF.png', :door_frame_id => 1
    DoorCombination.create :name => 'Porte simple avec un SLO et un SLF', :sections => 'SLO;SL;SLF', :preview_image_name => 'SLF_SL_SLF.png', :door_frame_id => 1
    DoorCombination.create :name => 'Porte simple avec un SLF et un SLO', :sections => 'SLF;SL;SLO', :preview_image_name => 'SLF_SL_SLF.png', :door_frame_id => 1
    DoorCombination.create :name => 'Porte double', :sections => 'SL;SL', :preview_image_name => 'SL_SL.png', :door_frame_id => 2
    DoorCombination.create :name => 'Porte double avec L gauche', :sections => 'L;SL;SL', :preview_image_name => 'L_SL_SL.png', :door_frame_id => 2
    DoorCombination.create :name => 'Porte double avec L droit', :sections => 'SL;SL;L', :preview_image_name => 'SL_SL_L.png', :door_frame_id => 2
    DoorCombination.create :name => 'Porte double avec deux L', :sections => 'L;SL;SL;L', :preview_image_name => 'L_SL_SL_L.png', :door_frame_id => 2
    DoorCombination.create :name => 'Porte double avec LP gauche', :sections => 'LP;SL;SL', :preview_image_name => 'LP_SL_SL.png', :door_frame_id => 2
    DoorCombination.create :name => 'Porte double avec LP droit', :sections => 'SL;SL;LP', :preview_image_name => 'SL_SL_LP.png', :door_frame_id => 2
    DoorCombination.create :name => 'Porte double avec deux LP', :sections => 'LP;SL;SL;LP', :preview_image_name => 'LP_SL_SL_LP.png', :door_frame_id => 2
    DoorCombination.create :name => 'Porte double avec SLF gauche', :sections => 'SLF;SL;SL', :preview_image_name => 'SLF_SL_SL.png', :door_frame_id => 2
    DoorCombination.create :name => 'Porte double avec SLF droit', :sections => 'SL;SL;SLF', :preview_image_name => 'SL_SL_SLF.png', :door_frame_id => 2
    DoorCombination.create :name => 'Porte double avec deux SLF', :sections => 'SLF;SL;SL;SLF', :preview_image_name => 'SLF_SL_SL_SLF.png', :door_frame_id => 2
    DoorCombination.create :name => 'Porte triple', :sections => 'SL;SL;SL', :preview_image_name => 'SL_SL_SL.png', :door_frame_id => 3
  end

  def self.down
    DoorCombination.delete_all
  end
end
