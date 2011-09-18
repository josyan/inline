class HomeController < ApplicationController
  skip_before_filter :login_required, :only => :set_lang
  def index
  end

  def set_lang
    session[:lang] = params[:lang]
    cookies.permanent[:lang] = session[:lang]
    redirect_to :back
  end
end
