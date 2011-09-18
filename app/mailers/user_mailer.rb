class UserMailer < ActionMailer::Base
  include TranslationGet
  default :from => 'info@glass-vision.net'
  
  def signup_notification(user)
    @url = activate_url(:id => user.activation_code)
    mail(:to => user.email, :subject => "[Glass Vision] " + trn_get('ACCOUNT_NEEDS_ACTIVATION_SUBJECT'))
  end
  
  def activation_to_admin(user)
    @admin_user = User.get_administrator
    @url  = edit_user_url(user.id)
    @user = user
    mail(:to => @admin_user.email, :subject => "[Glass Vision] " + trn_get('ACCOUNT_ACTIVATED_ADMIN_SUBJECT'))
  end
  
  def activation(user)
    @url = root_url
    mail(:to => user.email, :subject => "[Glass Vision] " + trn_get('ACCOUNT_ACTIVATED_SUBJECT'))
  end
  
  def forgot_password(user)
    @url  = reset_password_url(id => user.password_reset_code)
    mail(:to => user.email, :subject => "[Glass Vision] " + trn_get('ACCOUNT_CHANGE_PASSWORD_SUBJECT'))
  end
 
  def reset_password(user)
    mail(:to => user.email, :subject => "[Glass Vision] " + trn_get('ACCOUNT_PASSWORD_RESET_SUBJECT'))
  end

  def email(from, email)
    @text = email.body

    if (from.has_role?("administrator"))
      @recipients = User.all.select {|u| !u.has_role?("administrator") }.map(&:email).join(", ")
    else
      @recipients = User.all.select {|u| u.has_role?("administrator") }.map(&:email).join(", ")
    end
    mail(:from => from.email, :to => @recipients, :subject => "[Glass Vision] " + email.subject)
  end
end
