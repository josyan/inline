module TranslationGet
  def trn_get(key)
    str = Translation.get(key, ActiveRecord::Base.lang ) #session[:lang] ||= "fr")
    str.blank? ? str : str.html_safe
  end

  def trn_geth(key)
    str = Translation.geth(key,  ActiveRecord::Base.lang ).html_safe #session[:lang] ||= "fr")
    str.blank? ? str : str.html_safe
  end

  def trn_gett(key)
    str = Translation.gett(key,  ActiveRecord::Base.lang ).html_safe #session[:lang] ||= "fr")
    str.blank? ? str : str.html_safe
  end
end
