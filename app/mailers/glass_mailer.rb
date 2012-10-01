class GlassMailer < ActionMailer::Base
  include TranslationGet
  default :from => 'info@glass-vision.net'

  def glass_edition(glass)
    @glass = glass
    mail(:to => 'josyan.pierson@gmail.com', :subject => "[Glass Vision] Glass to check: ##{@glass.id}")
  end

end
