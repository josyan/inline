class DoorPanelFamiliesController < ApplicationController

  def index
    @door_panel_families = DoorPanelFamily.all(:order => :name)
  end

  def new
    @door_panel_family = DoorPanelFamily.new
    @slab_materials = SlabMaterial.all
  end

  def create
    @door_panel_family = DoorPanelFamily.new(params[:door_panel_family])
    if @door_panel_family.save
      flash[:notice] = trn_geth('LABEL_DOOR_PANEL_FAMILY') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      redirect_to door_panel_families_path
    else
      @slab_materials = SlabMaterial.all
      render :action => 'new'
    end
  end

  def edit
    @door_panel_family = DoorPanelFamily.find(params[:id])
    @slab_materials = SlabMaterial.all
  end

  def update
    @door_panel_family = DoorPanelFamily.find(params[:id])
    if @door_panel_family.update_attributes(params[:door_panel_family])
      flash[:notice] = trn_geth('LABEL_DOOR_PANEL_FAMILY') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to door_panel_families_path
    else
      @slab_materials = SlabMaterial.all
      render :action => 'edit'
    end
  end

  def destroy
    DoorPanelFamily.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_DOOR_PANEL_FAMILY') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    redirect_to door_panel_families_path
  end

end
