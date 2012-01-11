class DoorOpeningsController < ApplicationController

  def index
    @door_openings = DoorOpening.all(:order => :name)
  end

  def new
    @door_opening = DoorOpening.new
  end

  def create
    @door_opening = DoorOpening.new(params[:door_opening])
    if @door_opening.save
      flash[:notice] = trn_geth('LABEL_DOOR_OPENING') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      redirect_to door_openings_path
    else
      render :action => 'new'
    end
  end

  def edit
    @door_opening = DoorOpening.find(params[:id])
  end

  def update
    @door_opening = DoorOpening.find(params[:id])
    if @door_opening.update_attributes(params[:door_opening])
      flash[:notice] = trn_geth('LABEL_DOOR_OPENING') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to door_openings_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    DoorOpening.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_DOOR_OPENING') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    redirect_to door_openings_path
  end

end
