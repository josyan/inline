class DoorSectionDimensionsController < ApplicationController

  def index
    @door_section = DoorSection.find(params[:door_section_id])
  end

  def new
    @door_section = DoorSection.find(params[:door_section_id])
    @door_section_dimension = @door_section.door_section_dimensions.new
  end

  def create
    @door_section = DoorSection.find(params[:door_section_id])
    @door_section_dimension = @door_section.door_section_dimensions.new(params[:door_section_dimension])
    if @door_section_dimension.save
      flash[:notice] = trn_geth('LABEL_DOOR_SECTION_DIMENSION') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      redirect_to door_section_door_section_dimensions_path(@door_section)
    else
      render :action => 'new'
    end
  end

  def edit
    @door_section = DoorSection.find(params[:door_section_id])
    @door_section_dimension = DoorSectionDimension.find(params[:id])
  end

  def update
    @door_section = DoorSection.find(params[:door_section_id])
    @door_section_dimension = DoorSectionDimension.find(params[:id])
    if @door_section_dimension.update_attributes(params[:door_section_dimension])
      flash[:notice] = trn_geth('LABEL_DOOR_SECTION_DIMENSION') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to door_section_door_section_dimensions_path(@door_section)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @door_section = DoorSection.find(params[:door_section_id])
    DoorSectionDimension.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_DOOR_SECTION_DIMENSION') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    redirect_to door_section_door_section_dimensions_path(@door_section)
  end

end
