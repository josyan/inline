class DoorController < ApplicationController

  def new

    # create new door line with default settings
    @door_line = DoorLine.new
    @door_line.quotation_id = params[:id]

    @door_frames = DoorFrame.all(:order => 'sections')
    @door_line.door_frame = @door_frames.first

    @door_combinations = DoorCombination.all(:conditions => { :door_frame_id => @door_line.door_frame_id })
    @door_line.door_combination = @door_combinations.first

    @frame_profiles = FrameProfile.all(:order => :name)
    @door_line.frame_profile = @frame_profiles.first
  end

end
