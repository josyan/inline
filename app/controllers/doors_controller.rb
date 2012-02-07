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

    @door_borings = DoorBoring.all(:order => :name)
    @door_line.door_boring = @door_borings.first

    @options = Option.find(:all, :conditions => { :module_type_id => 2 }).sort_by { |o| o.tr_description }
    @selected_options = []

    @door_line.quantity = 1
  end

  def configure_panels
    door_combination = DoorCombination.find(params[:door_combination_id])

    # create and populate each section of the door
    previous_sections = params[:door_line_sections] ? params[:door_line_sections].dup : []
    @door_line_sections = door_combination.sections.split(';').map do |door_section_code|
      door_line_section = { :door_section => DoorSection.find_by_code(door_section_code) }
      door_line_section[:door_panels] = door_line_section[:door_section].door_panels
      door_line_section[:door_section_dimensions] = door_line_section[:door_section].door_section_dimensions
      door_line_section[:door_line_section] = DoorLineSection.new(:door_section => door_line_section[:door_section],
                                                                  :door_panel => door_line_section[:door_panels].first,
                                                                  :door_section_dimension => door_line_section[:door_section_dimensions].first)
      # check if we can somewhat recopy the previous configuration in the new one
      possible_choices = previous_sections.select { |s| s[:door_section_id] == door_line_section[:door_section].id.to_s }
      if possible_choices.length >= 1
        door_line_section[:door_line_section].door_panel_id = possible_choices[0][:door_panel_id].to_i unless possible_choices[0][:door_panel_id].blank?
        door_line_section[:door_line_section].door_section_dimension_id = possible_choices[0][:door_section_dimension_id].to_i unless possible_choices[0][:door_section_dimension_id].blank?
        if possible_choices.length > 1
          previous_sections.each_with_index do |section, index|
            if section[:door_section_id] == possible_choices.first[:door_section_id]
              previous_sections.delete_at index
              break
            end
          end
        end
      end
      door_line_section
    end

    # assign the glasses if possible
    previous_sections = params[:door_line_sections] ? params[:door_line_sections].dup : []
    @door_line_sections.each do |door_line_section|
      # check if we had a similar panel
      possible_choices = previous_sections.select { |s| s[:door_panel_id] == door_line_section[:door_line_section].door_panel_id.to_s }
      if possible_choices.length >= 1
        door_line_section[:door_line_section].door_glass_id = possible_choices[0][:door_glass_id] unless possible_choices[0][:door_glass_id].blank?
        if possible_choices.length > 1
          previous_sections.each_with_index do |section, index|
            if section[:door_panel_id] == possible_choices.first[:door_panel_id]
              previous_sections.delete_at index
              break
            end
          end
        end
      end
    end
  end

  def configure_glass_families
    door_panel = DoorPanel.find(params[:door_panel_id])
    @door_glass_families = DoorGlassFamily.find(:all, :conditions => { :id => door_panel.door_glasses.map { |dg| dg.door_glass_family_id }.uniq }, :order => 'name')
    unless params[:door_glass_id].blank?
      door_glass = DoorGlass.find(params[:door_glass_id])
      @door_glass_family_id = door_glass.door_glass_family_id
    end
  end

  def configure_glasses
    door_glass_family = DoorGlassFamily.find(params[:door_glass_family_id])

    @door_glasses = door_glass_family.door_glasses
    @door_glass_id = @door_glasses.first.id unless @door_glasses.empty?
    @door_glass_id = params[:door_glass_id].to_i if params[:door_glass_id] and @door_glasses.map(&:id).include?(params[:door_glass_id].to_i)
  end

  def configure_openings
    door_combination = DoorCombination.find(params[:door_combination_id])
    @door_opening_id = params[:door_opening_id]
    @door_openings = door_combination.door_openings(:order => :id)
    @door_opening_id = @door_openings.first.id unless @door_openings.map(&:id).include?(@door_opening_id)
  end

  def create

  end

end
