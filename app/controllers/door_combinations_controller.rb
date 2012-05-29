class DoorCombinationsController < ApplicationController

  def index
    @door_combinations = DoorCombination.all(:order => :name)
  end

  def new
    @door_combination = DoorCombination.new
    @door_openings = DoorOpening.all(:order => :id)
  end

  def create
    @door_combination = DoorCombination.new(params[:door_combination])
    if @door_combination.save
      flash[:notice] = trn_geth('LABEL_DOOR_COMBINATION') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_F')
      redirect_to door_combinations_path
    else
      render :action => 'new'
    end
  end

  def edit
    @door_combination = DoorCombination.find(params[:id])
    @door_openings = DoorOpening.all(:order => :id)
  end

  def update
    @door_combination = DoorCombination.find(params[:id])
    if @door_combination.update_attributes(params[:door_combination])
      flash[:notice] = trn_geth('LABEL_DOOR_COMBINATION') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_F')
      redirect_to door_combinations_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    DoorCombination.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_DOOR_COMBINATION') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_F')
    redirect_to door_combinations_path
  end

end
