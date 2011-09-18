class DimensionController < ApplicationController
  def add
    @dimension = params[:type].constantize.new
    @dimension.serie_id = params[:serie_id]
  end

  def create
    @dimension = params[:type].constantize.new(params[:dimension])
    if @dimension.save
      flash[:notice] = trn_geth('LABEL_DIMENSION') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      redirect_to :controller => "serie", :action => 'show', :id => @dimension.serie_id
    else
      render :action => 'add'
    end
  end

  def edit
    @dimension = Dimension.find(params[:id])
  end

  def update
    @dimension = Dimension.find(params[:id])
    if @dimension.update_attributes(params[:dimension])
      flash[:notice] = trn_geth('LABEL_DIMENSION') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to :controller => "serie", :action => 'show', :id => @dimension.serie_id
    else
      render :action => 'edit'
    end
  end

  def delete
    dimension = Dimension.find(params[:id])
    dimension.destroy
    flash[:notice] = trn_geth('LABEL_DIMENSION') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    redirect_to :controller => "serie", :action => 'show', :id => dimension.serie_id
  end
end
