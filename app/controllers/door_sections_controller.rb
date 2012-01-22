class DoorSectionsController < ApplicationController

  def index
    @door_sections = DoorSection.all(:order => :name)
  end

end
