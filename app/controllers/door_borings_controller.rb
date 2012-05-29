class DoorBoringsController < ApplicationController

  def index
    @door_borings = DoorBoring.all(:order => :name)
  end

  def new
    @door_boring = DoorBoring.new
  end

  def create
    @door_boring = DoorBoring.new(params[:door_boring])
    if @door_boring.save
      flash[:notice] = trn_geth('LABEL_DOOR_BORING') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_M')
      redirect_to door_borings_path
    else
      render :action => 'new'
    end
  end

  def edit
    @door_boring = DoorBoring.find(params[:id])
  end

  def update
    @door_boring = DoorBoring.find(params[:id])
    if @door_boring.update_attributes(params[:door_boring])
      flash[:notice] = trn_geth('LABEL_DOOR_BORING') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_M')
      redirect_to door_borings_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    DoorBoring.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_DOOR_BORING') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_M')
    redirect_to door_borings_path
  end

end
