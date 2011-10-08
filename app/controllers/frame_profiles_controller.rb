class FrameProfilesController < ApplicationController

  def index
    @frame_profiles = FrameProfile.all(:order => :name)
  end

  def new
    @frame_profile = FrameProfile.new
  end

  def create
    @frame_profile = FrameProfile.new(params[:frame_profile])
    if @frame_profile.save
      flash[:notice] = trn_geth('LABEL_FRAME_PROFILE') + " " + trn_get('MSG_SUCCESSFULLY_CREATED_M')
      redirect_to frame_profiles_path
    else
      render :action => 'new'
    end
  end

  def edit
    @frame_profile = FrameProfile.find(params[:id])
  end

  def update
    @frame_profile = FrameProfile.find(params[:id])
    if @frame_profile.update_attributes(params[:frame_profile])
      flash[:notice] = trn_geth('LABEL_FRAME_PROFILE') + " " + trn_get('MSG_SUCCESSFULLY_MODIFIED_M')
      redirect_to frame_profiles_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    FrameProfile.find(params[:id]).destroy
    flash[:notice] = trn_geth('LABEL_FRAME_PROFILE') + " " + trn_get('MSG_SUCCESSFULLY_DELETED_M')
    redirect_to frame_profiles_path
  end

end
