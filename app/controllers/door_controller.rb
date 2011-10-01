class DoorController < ApplicationController

  def new
    @door_line = DoorLine.new
    @door_line.quotation_id = params[:id]

    @door_frames = DoorFrame.all(:order => 'sections')
  end

  def step2
    @door_line = DoorLine.new(params[:door_line])

  end

end
