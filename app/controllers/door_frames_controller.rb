class DoorFramesController < ApplicationController

  def index
    @door_frames = DoorFrame.all(:order => :name)
  end

  def new
    @door_frame = DoorFrame.new
  end

  def create
    @door_frame = DoorFrame.new(params[:door_frame])
    if @door_frame.save
      flash[:notice] = trn_geth('LABEL_DOOR_FRAME') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_M')
      redirect_to door_frames_path
    else
      render :action => 'new'
    end
  end

  def edit
    @door_frame = DoorFrame.find(params[:id])
  end

  def update
    @door_frame = DoorFrame.find(params[:id])
    if @door_frame.update_attributes(params[:door_frame])
      flash[:notice] = trn_geth('LABEL_DOOR_FRAME') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_M')
      redirect_to door_frames_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    DoorFrame.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_DOOR_FRAME') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_M')
    redirect_to door_frames_path
  end

end
