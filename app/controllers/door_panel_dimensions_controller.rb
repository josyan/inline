class DoorPanelDimensionsController < ApplicationController

  def index
    @door_panel_family = DoorPanelFamily.find(params[:door_panel_family_id])
    @door_panel = DoorPanel.find(params[:door_panel_id])
  end

  def new
    @door_panel_family = DoorPanelFamily.find(params[:door_panel_family_id])
    @door_panel = DoorPanel.find(params[:door_panel_id])
    @door_panel_dimension = @door_panel.door_panel_dimensions.new
  end

  def create
    @door_panel_family = DoorPanelFamily.find(params[:door_panel_family_id])
    @door_panel = DoorPanel.find(params[:door_panel_id])
    @door_panel_dimension = @door_panel.door_panel_dimensions.new(params[:door_panel_dimension])
    if @door_panel_dimension.save
      flash[:notice] = trn_geth('LABEL_DOOR_PANEL_DIMENSION') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      redirect_to door_panel_family_door_panel_door_panel_dimensions_path(@door_panel_family, @door_panel)
    else
      render :action => 'new'
    end
  end

  def edit
    @door_panel_family = DoorPanelFamily.find(params[:door_panel_family_id])
    @door_panel = DoorPanel.find(params[:door_panel_id])
    @door_panel_dimension = DoorPanelDimension.find(params[:id])
  end

  def update
    @door_panel_family = DoorPanelFamily.find(params[:door_panel_family_id])
    @door_panel = DoorPanel.find(params[:door_panel_id])
    @door_panel_dimension = DoorPanelDimension.find(params[:id])
    if @door_panel_dimension.update_attributes(params[:door_panel_dimension])
      flash[:notice] = trn_geth('LABEL_DOOR_PANEL_DIMENSION') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to door_panel_family_door_panel_door_panel_dimensions_path(@door_panel_family, @door_panel)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @door_panel_family = DoorPanelFamily.find(params[:door_panel_family_id])
    @door_panel = DoorPanel.find(params[:door_panel_id])
    DoorPanelDimension.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_DOOR_PANEL_DIMENSION') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    redirect_to door_panel_family_door_panel_door_panel_dimensions_path(@door_panel_family, @door_panel)
  end

end
