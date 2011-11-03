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

  def configure
    combination = DoorCombination.find(params[:door_combination_id])
    @sections = combination.sections.split(';').map do |section_code|
      section = { :door_line_section => DoorLineSection.new,
                  :door_section => DoorSection.find_by_code(section_code) }
      section[:door_panels] = section[:door_section].door_panels
      unless section[:door_panels].empty?
        section[:door_line_section].door_panel = section[:door_panels].first
        section[:door_glasses] = section[:door_panels].first.door_glasses
        section[:door_glass_families] = DoorGlassFamily.all(:conditions => { :id => section[:door_panels].first.door_glasses.map { |glass| glass.door_glass_family_id }.uniq })
      end
      section
    end

  end

  def create

  end

end
