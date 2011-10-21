class DoorsController < ApplicationController

  def new

    # create new door line with default settings
    @door_line = DoorLine.new
    @door_line.quotation_id = params[:id]

    @door_frames = DoorFrame.all(:order => 'sections')
    @door_line.door_frame = @door_frames.first

    @door_line.door_combination = DoorCombination.first(:conditions => { :door_frame_id => @door_line.door_frame_id })

    @frame_profiles = FrameProfile.all(:order => :name)
    @door_line.frame_profile = @frame_profiles.first

    @slab_materials = SlabMaterial.all(:order => :name)
    @door_line.slab_material = @slab_materials.first

    @door_panels = DoorPanel.all(:order => :name)
    @door_line.door_panel = @door_panels.first
  end

  def create

  end

end
