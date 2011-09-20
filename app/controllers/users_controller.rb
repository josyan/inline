class UsersController < ApplicationController
  layout 'application'
  before_filter :not_logged_in_required, :only => [:new, :create] 
  before_filter :login_required, :only => [:show, :edit, :update]
  before_filter :check_administrator_role, :only => [:index, :destroy, :enable]
  
  def index
    @users = User.all()
  end
  
  #This show action only allows users to view their own profile, but allows admins to see /edit anyone
  def show
    get_user_for_edit
  end
    
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    cookies.delete :auth_token
    @user = User.new(params[:user])
    @user.save!
    #Uncomment to have the user logged in after creating an account - Not Recommended
    #self.current_user = @user
    flash[:notice] = trn_get('SIGNUP_THANKS_FLASH')
    redirect_to login_path    
  rescue ActiveRecord::RecordInvalid
    flash[:error] = trn_get('SIGNUP_PROBLEM_FLASH')
    render :action => 'new'
  end
  
  #This edit action only allows users to edit their own profile
  def edit
    get_user_for_edit
  end
  
  def update
    @user = User.find(params[:id])
    debug_log "Saving user id #{@user.id}, discount is #{params[:user]}"
    if @user.update_attributes(params[:user])

      # saving access to modules
      @user.module_types.clear
      params[:module_type].each do |mt_id, active|
        @user.module_types << ModuleType.find(mt_id) if active.to_i == 1
      end

      flash[:notice] = trn_get('USER_UPDATED_FLASH')
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end
  
  def disable
    @user = User.find(params[:user_id])
    if @user.update_attribute(:enabled, false)
      flash[:notice] = trn_get('USER_DISABLED_FLASH')
    else
      flash[:error] = trn_get('USER_DISABLE_PROBLEM_FLASH')
    end
    redirect_to :action => 'index'
  end
 
  def enable
    @user = User.find(params[:user_id])
    if @user.update_attribute(:enabled, true)
      flash[:notice] = trn_get('USER_ENABLED_FLASH')
    else
      flash[:error] = trn_get('USER_ENABLE_PROBLEM_FLASH')
    end
      redirect_to :action => 'index'
  end

protected
  def get_user_for_edit
    if current_user.has_role?('administrator')
      @user = User.find(params[:id])
    else
      @user = current_user # unless current_user.has_role?('administrator')
    end
  end 
end

