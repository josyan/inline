class AccountsController < ApplicationController
  layout 'application'
  before_filter :login_required, :except => :show
  before_filter :not_logged_in_required, :only => :show
 
  # Activate action
  def show
    # Uncomment and change paths to have user logged in after activation - not recommended
    #self.current_user = User.find_and_activate!(params[:id])
  User.find_and_activate!(params[:id])
    flash[:notice] = trn_geth('ACCOUNT_ACTIVATED_EMAIL')
    redirect_to login_path
  rescue User::ArgumentError
    flash[:notice] = trn_geth('ACTIVATION_CODE_NOT_FOUND_FLASH')
    redirect_to new_user_path 
  rescue User::ActivationCodeNotFound
    flash[:notice] = trn_geth('ACTIVATION_CODE_NOT_FOUND_FLASH')
    redirect_to new_user_path
  rescue User::AlreadyActivated
    flash[:notice] = trn_geth('ACCOUNT_ACTIVATED_FLASH')
    redirect_to login_path
  end
 
  def edit
  end
  
  # Change password action  
  def update
  return unless request.post?
    if User.authenticate(current_user.login, params[:old_password])
      if ((params[:password] == params[:password_confirmation]) && !params[:password_confirmation].blank?)
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]        
    if current_user.save
          flash[:notice] = trn_geth('PASSWORD_RESET_FLASH')
          redirect_to root_path #profile_url(current_user.login)
        else
          flash[:error] = trn_geth('PASSWORD_NOT_RESET_FLASH')
          render :action => 'edit'
        end
      else
        flash[:error] = trn_geth('PASSWORD_MISMATCH_FLASH')
        @old_password = params[:old_password]
        render :action => 'edit'      
      end
    else
      flash[:error] = trn_geth('OLD_PASSWORD_INCORRECT_FLASH')
      render :action => 'edit'
    end 
  end
  
end

