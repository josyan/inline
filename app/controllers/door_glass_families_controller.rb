class DoorGlassFamiliesController < ApplicationController

  def index
    @door_glass_families = DoorGlassFamily.all(:order => :name)
  end

  def new
    @door_glass_family = DoorGlassFamily.new
  end

  def create
    @door_glass_family = DoorGlassFamily.new(params[:door_glass_family])
    if @door_glass_family.save
      flash[:notice] = trn_geth('LABEL_DOOR_GLASS_FAMILY') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      redirect_to door_glass_families_path
    else
      render :action => 'new'
    end
  end

  def edit
    @door_glass_family = DoorGlassFamily.find(params[:id])
  end

  def update
    @door_glass_family = DoorGlassFamily.find(params[:id])
    if @door_glass_family.update_attributes(params[:door_glass_family])
      flash[:notice] = trn_geth('LABEL_DOOR_GLASS_FAMILY') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to door_glass_families_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    DoorGlassFamily.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_DOOR_GLASS_FAMILY') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    redirect_to door_glass_families_path
  end

end
