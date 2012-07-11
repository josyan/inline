class QuotationMailer < ActionMailer::Base
  include TranslationGet
  default :from => 'info@glass-vision.net'

  def created_notification(quotation)
    @admin_user = User.get_administrator
 
    @user = quotation.user
    @quotation = quotation
    @url = url_for(:host => "quotations.glass-vision.net", :controller => "quotation", :action => "show", :id => quotation.slug)
    
    mail(:to => @admin_user.email, :subject => "[Glass Vision] #{trn_get('SUBJECT_NEW_QUOTATION_CREATED')}")
  end
  
end
