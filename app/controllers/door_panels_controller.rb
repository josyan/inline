class DoorPanelsController < ApplicationController

  def index
    @door_panels = DoorPanel.all(:order => :name)
  end

  def new
    @door_panel = DoorPanel.new
  end

  def create
    @door_panel = DoorPanel.new(params[:door_panel])
    if @door_panel.save
      flash[:notice] = trn_geth('LABEL_DOOR_PANEL') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_M')
      redirect_to door_panels_path
    else
      render :action => 'new'
    end
  end

  def edit
    @door_panel = DoorPanel.find(params[:id])
  end

  def update
    @door_panel = DoorPanel.find(params[:id])
    if @door_panel.update_attributes(params[:door_panel])
      flash[:notice] = trn_geth('LABEL_DOOR_PANEL') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_M')
      redirect_to door_panels_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    DoorPanel.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_DOOR_PANEL') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_M')
    redirect_to door_panels_path
  end

end
