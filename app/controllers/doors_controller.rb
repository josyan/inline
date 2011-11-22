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
  end

  def configure_panels
    door_combination = DoorCombination.find(params[:door_combination_id])
    @door_line_sections = door_combination.sections.split(';').map do |door_section_code|
      door_line_section = { :door_section => DoorSection.find_by_code(door_section_code) }
      door_line_section[:door_panels] = door_line_section[:door_section].door_panels
      door_line_section[:door_line_section] = DoorLineSection.new(:door_section => door_line_section[:door_section],
                                                                  :door_panel => door_line_section[:door_panels].first)
      door_line_section
    end
  end

  def configure_glass_families

  end

  def create

  end

end
