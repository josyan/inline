class OpeningController < ApplicationController
  before_filter :check_administrator_role

  def list
    @openings = Opening.all(:order => "name")
  end

  def show
    @opening = Opening.find(params[:id])
  end

  def add
    @opening = Opening.new
  end

  def create
    @opening = Opening.new(params[:opening])
    if @opening.save
      flash[:notice] = trn_geth('LABEL_OPENING') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      redirect_to :action => 'list'
    else
      render :action => 'add'
    end
  end

  def edit
    @opening = Opening.find(params[:id])
  end

  def update
    @opening = Opening.find(params[:id])
    if @opening.update_attributes(params[:opening])
      flash[:notice] = trn_geth('LABEL_OPENING') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  def delete
    Opening.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_OPENING') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    redirect_to :action => 'list'
  end
end
