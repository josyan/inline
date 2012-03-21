class DoorGlassesController < ApplicationController

  def index
    @door_glass_family = DoorGlassFamily.find(params[:door_glass_family_id])
  end

  def new
    @door_glass_family = DoorGlassFamily.find(params[:door_glass_family_id])
    @door_glass = @door_glass_family.door_glasses.new
    @door_panel_families = DoorPanelFamily.all
  end

  def create
    @door_glass_family = DoorGlassFamily.find(params[:door_glass_family_id])
    @door_glass = @door_glass_family.door_glasses.new(params[:door_glass])
    if @door_glass.save
      flash[:notice] = trn_geth('LABEL_DOOR_GLASS') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_M')
      redirect_to door_glass_family_door_glasses_path(@door_glass_family)
    else
      @door_panel_families = DoorPanelFamily.all
      render :action => 'new'
    end
  end

  def edit
    @door_glass_family = DoorGlassFamily.find(params[:door_glass_family_id])
    @door_glass = DoorGlass.find(params[:id])
    @door_panel_families = DoorPanelFamily.all
  end

  def update
    @door_glass_family = DoorGlassFamily.find(params[:door_glass_family_id])
    @door_glass = DoorGlass.find(params[:id])
    if @door_glass.update_attributes(params[:door_glass])
      flash[:notice] = trn_geth('LABEL_DOOR_GLASS') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_M')
      redirect_to door_glass_family_door_glasses_path(@door_glass_family)
    else
      @door_panel_families = DoorPanelFamily.all
      render :action => 'edit'
    end
  end

  def destroy
    @door_glass_family = DoorGlassFamily.find(params[:door_glass_family_id])
    DoorGlass.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_DOOR_GLASS') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_M')
    redirect_to door_glass_family_door_glasses_path(@door_glass_family)
  end

end
