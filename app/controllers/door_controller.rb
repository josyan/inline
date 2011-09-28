class DoorController < ApplicationController

  def new
    @door_line = DoorLine.new
    @door_line.quotation_id = params[:id]

    @door_frames = DoorFrame.all(:order => 'sections')
  end

end
