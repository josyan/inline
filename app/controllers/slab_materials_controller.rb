class SlabMaterialsController < ApplicationController

  def index
    @slab_materials = SlabMaterial.all(:order => :name)
  end

  def edit
    @slab_material = SlabMaterial.find(params[:id])
  end

  def update
    @slab_material = SlabMaterial.find(params[:id])
    if @slab_material.update_attributes(params[:slab_material])
      flash[:notice] = trn_geth('LABEL_SLAB_MATERIAL') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_M')
      redirect_to slab_materials_path
    else
      render :action => 'edit'
    end
  end

end
