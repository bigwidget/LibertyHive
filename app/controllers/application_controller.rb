class ApplicationController < ActionController::Base
  protect_from_forgery

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
  def store_referer
    session[:return_to] = request.env["HTTP_REFERER"]
  end
    
end
