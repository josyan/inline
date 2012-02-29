class DoorSectionsController < ApplicationController

  def index
    @door_sections = DoorSection.all(:order => :name)
  end

  def edit
    @door_section = DoorSection.find(params[:id])
  end

  def update
    @door_section = DoorSection.find(params[:id])
    if @door_section.update_attributes(params[:door_section])
      flash[:notice] = trn_geth('LABEL_DOOR_SECTION') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to door_sections_path
    else
      render :action => 'edit'
    end
  end

end
