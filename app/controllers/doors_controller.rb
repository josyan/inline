class DoorsController < ApplicationController

  def new
    init_variables

    # create new door line with default settings
    @door_line = DoorLine.new
    @door_line.quotation_id = params[:id]
    @door_line.door_frame = @door_frames.first
    @door_line.door_combination = DoorCombination.first(:conditions => { :door_frame_id => @door_line.door_frame_id })
    @door_line.frame_profile = @frame_profiles.first
    @door_line.slab_material = @slab_materials.first
    @door_line.door_boring = @door_borings.first
    @door_line.quantity = 1

    init_options
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
    @door_line = DoorLine.new(params[:door_line])
    # TODO remove later
    params[:price] = 0
    if @door_line.save
      params[:door_line_sections].each_with_index do |line_section, index|
        line_section.each do |key, value|
          line_section.delete key if value.blank?
        end
        line_section[:order] = index
        @door_line.door_line_sections << DoorLineSection.new(line_section)
      end
      get_options_from_params(params).each do |o|
        @door_line.door_line_options << DoorLineOption.new(:option_id => o,
                                                           :quantity => (params["option_quantity_#{o}"] || 1).to_f)
      end
      redirect_to quotation_path(@door_line.quotation_id)
    else
      init_variables
      init_options
      render :action => 'new'
    end
  end

  private ####################################################################

  def init_variables
    @door_frames = DoorFrame.all(:order => 'sections')
    @frame_profiles = FrameProfile.all(:order => :name)
    @slab_materials = SlabMaterial.all(:order => :name)
    @door_borings = DoorBoring.all(:order => :name)
    @options = Option.find(:all, :conditions => { :module_type_id => 2 }).sort_by { |o| o.tr_description }
  end

  def init_options
    if @door_line.new_record?
      @selected_options = []
    else
      @selected_options = []
    end
  end

  def get_options_from_params(params)
    new_selected_options = params[:options] ? params[:options].map { |o| o.to_i } : []

    # we have params[:option_category_<id>] that hold a single option id for single-select categories
    # we can take those id's and merge them into new_selected_options
    more_options = params.keys.grep(/options_category_[0-9]+/).map { |k| params[k].to_i }.flatten
    new_selected_options += more_options
    # remove any options with index of -1, those are the special "None" options
    new_selected_options.reject! { |i| i == -1 }
    new_selected_options
  end

end
