class DoorPanelsController < ApplicationController

  def index
    @door_panel_family = DoorPanelFamily.find(params[:door_panel_family_id])
  end

  def new
    @door_panel_family = DoorPanelFamily.find(params[:door_panel_family_id])
    @door_panel = @door_panel_family.door_panels.new
    @door_sections = DoorSection.all(:order => :name)
  end

  def create
    @door_panel_family = DoorPanelFamily.find(params[:door_panel_family_id])
    @door_panel = @door_panel_family.door_panels.new(params[:door_panel])
    if @door_panel.save
      flash[:notice] = trn_geth('LABEL_DOOR_PANEL') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_M')
      redirect_to door_panel_family_door_panels_path(@door_panel_family)
    else
      render :action => 'new'
    end
  end

  def edit
    @door_panel_family = DoorPanelFamily.find(params[:door_panel_family_id])
    @door_panel = DoorPanel.find(params[:id])
    @door_sections = DoorSection.all(:order => :name)
  end

  def update
    @door_panel_family = DoorPanelFamily.find(params[:door_panel_family_id])
    @door_panel = DoorPanel.find(params[:id])
    if @door_panel.update_attributes(params[:door_panel])
      flash[:notice] = trn_geth('LABEL_DOOR_PANEL') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_M')
      redirect_to door_panel_family_door_panels_path(@door_panel_family)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @door_panel_family = DoorPanelFamily.find(params[:door_panel_family_id])
    DoorPanel.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_DOOR_PANEL') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_M')
    redirect_to door_panel_family_door_panels_path(@door_panel_family)
  end

end
