class PopulateDoorOpenings < ActiveRecord::Migration
  def self.up
    DoorOpening.create :name => 'Gauche GI', :preview_image_name => 'SL_SL_SL_G_GI.png'
    DoorOpening.create :name => 'Gauche GE', :preview_image_name => 'SL_SL_SL_G_GE.png'
    DoorOpening.create :name => 'Gauche DI', :preview_image_name => 'SL_SL_SL_G_DI.png'
    DoorOpening.create :name => 'Gauche DE', :preview_image_name => 'SL_SL_SL_G_DE.png'

    DoorOpening.create :name => 'Gauche GI', :preview_image_name => 'SL_SL_SLF_G_GI.png'
    DoorOpening.create :name => 'Gauche GE', :preview_image_name => 'SL_SL_SLF_G_GE.png'
    DoorOpening.create :name => 'Gauche DI', :preview_image_name => 'SL_SL_SLF_G_DI.png'
    DoorOpening.create :name => 'Gauche DE', :preview_image_name => 'SL_SL_SLF_G_DE.png'

    DoorOpening.create :name => 'Droite GI', :preview_image_name => 'SL_SL_SLF_D_GI.png'
    DoorOpening.create :name => 'Droite GE', :preview_image_name => 'SL_SL_SLF_D_GE.png'
    DoorOpening.create :name => 'Droite DI', :preview_image_name => 'SL_SL_SLF_D_DI.png'
    DoorOpening.create :name => 'Droite DE', :preview_image_name => 'SL_SL_SLF_D_DE.png'

    DoorOpening.create :name => 'Droite GI', :preview_image_name => 'SL_SL_SL_D_GI.png'
    DoorOpening.create :name => 'Droite GE', :preview_image_name => 'SL_SL_SL_D_GE.png'
    DoorOpening.create :name => 'Droite DI', :preview_image_name => 'SL_SL_SL_D_DI.png'
    DoorOpening.create :name => 'Droite DE', :preview_image_name => 'SL_SL_SL_D_DE.png'

    DoorOpening.create :name => 'Centre GI', :preview_image_name => 'SL_SL_SL_C_GI.png'
    DoorOpening.create :name => 'Centre GE', :preview_image_name => 'SL_SL_SL_C_GE.png'
    DoorOpening.create :name => 'Centre DI', :preview_image_name => 'SL_SL_SL_C_DI.png'
    DoorOpening.create :name => 'Centre DE', :preview_image_name => 'SL_SL_SL_C_DE.png'

    DoorOpening.create :name => 'GI', :preview_image_name => 'SL_SLO_C_GI.png'
    DoorOpening.create :name => 'GE', :preview_image_name => 'SL_SLO_C_GE.png'

    DoorOpening.create :name => 'Gauche GI', :preview_image_name => 'SL_SL_G_GI.png'
    DoorOpening.create :name => 'Gauche GE', :preview_image_name => 'SL_SL_G_GE.png'
    DoorOpening.create :name => 'Gauche DI', :preview_image_name => 'SL_SL_G_DI.png'
    DoorOpening.create :name => 'Gauche DE', :preview_image_name => 'SL_SL_G_DE.png'

    DoorOpening.create :name => 'Gauche/Droite GI', :preview_image_name => 'SL_SL_GD_GI.png'
    DoorOpening.create :name => 'Gauche/Droite GE', :preview_image_name => 'SL_SL_GD_GE.png'
    DoorOpening.create :name => 'Gauche/Droite DI', :preview_image_name => 'SL_SL_GD_DI.png'
    DoorOpening.create :name => 'Gauche/Droite DE', :preview_image_name => 'SL_SL_GD_DE.png'

    DoorOpening.create :name => 'GI', :preview_image_name => 'SL_SLF_C_GI.png'
    DoorOpening.create :name => 'GE', :preview_image_name => 'SL_SLF_C_GE.png'
    DoorOpening.create :name => 'DI', :preview_image_name => 'SL_SLF_C_DI.png'
    DoorOpening.create :name => 'DE', :preview_image_name => 'SL_SLF_C_DE.png'

    DoorOpening.create :name => 'Droite GI', :preview_image_name => 'SL_SL_D_GI.png'
    DoorOpening.create :name => 'Droite GE', :preview_image_name => 'SL_SL_D_GE.png'
    DoorOpening.create :name => 'Droite DI', :preview_image_name => 'SL_SL_D_DI.png'
    DoorOpening.create :name => 'Droite DE', :preview_image_name => 'SL_SL_D_DE.png'

    DoorOpening.create :name => 'DI', :preview_image_name => 'SLO_SL_SLF_C_DI.png'
    DoorOpening.create :name => 'DE', :preview_image_name => 'SLO_SL_SLF_C_DE.png'

    DoorOpening.create :name => 'DI', :preview_image_name => 'SLO_SL_C_DI.png'
    DoorOpening.create :name => 'DE', :preview_image_name => 'SLO_SL_C_DE.png'

    DoorOpening.create :name => 'Gauche GI', :preview_image_name => 'SLF_SL_SL_SLF_G_GI.png'
    DoorOpening.create :name => 'Gauche GE', :preview_image_name => 'SLF_SL_SL_SLF_G_GE.png'
    DoorOpening.create :name => 'Gauche DI', :preview_image_name => 'SLF_SL_SL_SLF_G_DI.png'
    DoorOpening.create :name => 'Gauche DE', :preview_image_name => 'SLF_SL_SL_SLF_G_DE.png'

    DoorOpening.create :name => 'Droite GI', :preview_image_name => 'SLF_SL_SL_SLF_D_GI.png'
    DoorOpening.create :name => 'Droite GE', :preview_image_name => 'SLF_SL_SL_SLF_D_GE.png'
    DoorOpening.create :name => 'Droite DI', :preview_image_name => 'SLF_SL_SL_SLF_D_DI.png'
    DoorOpening.create :name => 'Droite DE', :preview_image_name => 'SLF_SL_SL_SLF_D_DE.png'

    DoorOpening.create :name => 'GI', :preview_image_name => 'SLF_SL_SLO_C_GI.png'
    DoorOpening.create :name => 'GE', :preview_image_name => 'SLF_SL_SLO_C_GE.png'

    DoorOpening.create :name => 'Gauche GI', :preview_image_name => 'SLF_SL_SL_G_GI.png'
    DoorOpening.create :name => 'Gauche GE', :preview_image_name => 'SLF_SL_SL_G_GE.png'
    DoorOpening.create :name => 'Gauche DI', :preview_image_name => 'SLF_SL_SL_G_DI.png'
    DoorOpening.create :name => 'Gauche DE', :preview_image_name => 'SLF_SL_SL_G_DE.png'

    DoorOpening.create :name => 'Droite GI', :preview_image_name => 'SLF_SL_SL_D_GI.png'
    DoorOpening.create :name => 'Droite GE', :preview_image_name => 'SLF_SL_SL_D_GE.png'
    DoorOpening.create :name => 'Droite DI', :preview_image_name => 'SLF_SL_SL_D_DI.png'
    DoorOpening.create :name => 'Droite DE', :preview_image_name => 'SLF_SL_SL_D_DE.png'

    DoorOpening.create :name => 'GI', :preview_image_name => 'SLF_SL_C_GI.png'
    DoorOpening.create :name => 'GE', :preview_image_name => 'SLF_SL_C_GE.png'
    DoorOpening.create :name => 'DI', :preview_image_name => 'SLF_SL_C_DI.png'
    DoorOpening.create :name => 'DE', :preview_image_name => 'SLF_SL_C_DE.png'

    DoorOpening.create :name => 'GI', :preview_image_name => 'SLF_SL_SLF_C_GI.png'
    DoorOpening.create :name => 'GE', :preview_image_name => 'SLF_SL_SLF_C_GE.png'
    DoorOpening.create :name => 'DI', :preview_image_name => 'SLF_SL_SLF_C_DI.png'
    DoorOpening.create :name => 'DE', :preview_image_name => 'SLF_SL_SLF_C_DE.png'

    DoorOpening.create :name => 'GI', :preview_image_name => 'SL_C_GI.png'
    DoorOpening.create :name => 'GE', :preview_image_name => 'SL_C_GE.png'
    DoorOpening.create :name => 'DI', :preview_image_name => 'SL_C_DI.png'
    DoorOpening.create :name => 'DE', :preview_image_name => 'SL_C_DE.png'
  end

  def self.down
    DoorOpening.delete_all
  end
end
