 class SessionController < ApplicationController
   layout 'application'
   before_filter :login_required, :only => :destroy
   before_filter :not_logged_in_required, :only => [:new, :create]
   
   # for some reason, setting language after login failure routes to show
   def show
     redirect_to login_path    
   end
   # render new.rhtml
   def new
   end
  
   def create
     password_authentication(params[:login], params[:password])
   end
  
   def destroy
     self.current_user.forget_me if logged_in?
     cookies.delete :auth_token
     reset_session
     flash[:notice] = trn_get('LOGGED_OUT_FLASH')
     redirect_to login_path    
   end
   
   protected
   
   # Updated 2/20/08
   def password_authentication(login, password)
     user = User.authenticate(login, password)
     if user == nil
       failed_login('LOGIN_FAILED_FLASH')
     elsif user.activated_at.blank?  
       failed_login('LOGIN_ACCT_NOT_ACTIVE_FLASH')
     elsif user.enabled == false
       failed_login('LOGIN_ACCT_DISABLED_FLASH')
     else
       self.current_user = user
       successful_login
     end
   end
   
   
   private
   
   def failed_login(message)
     flash.now[:error] = trn_get(message)
     render :action => 'new'
   end
   
   def successful_login
     if params[:remember_me] == "1"
       self.current_user.remember_me
       cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
     end
     flash[:notice] = trn_get('LOGIN_SUCCESSFUL_FLASH')
     return_to = session[:return_to]
     if return_to.nil?
       redirect_to user_path(self.current_user)
     else
       redirect_to return_to
     end
   end
  
 end

