class PreviewImageController < ApplicationController
  before_filter :check_administrator_role

  def list
    @images = PreviewImage.all(:order => "image_name")
  end

  def show
    @image = PreviewImage.find(params[:id])
  end

  def edit
    @image = PreviewImage.find(params[:id])
  end

  def add
    @serie = Serie.new
  end
  
  def create
    @image = PreviewImage.new(params[:image])
    if @image.save
      flash[:notice] = trn_geth('LABEL_PREVIEW_IMAGE') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      redirect_to :action => 'list'
    else
      render :action => 'add'
    end  
  end
  
  def delete
    PreviewImage.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_PREVIEW_IMAGE') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    redirect_to :action => 'list'    
  end
  
  def update
    @image = PreviewImage.find(params[:id])
    if @image.update_attributes(params[:image])
      flash[:notice] = trn_geth('LABEL_PREVIEW_IMAGE') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end    
  end
end
