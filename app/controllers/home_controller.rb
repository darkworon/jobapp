class HomeController < ApplicationController
  skip_before_filter :authorize
  
  def index

    if params[:set_locale]
      #current_uri = get_uri_from_url(request.url)
      session[:return_to] = request.fullpath
      I18n.locale = params[:set_locale]
      redirect_to home_path(locale: params[:set_locale])
    end
    #if session[:return_to] and params[:set_locale]
    #  redirect_to session[:return_to]
    #  session[:return_to] = nil
    #end
    unless params[:locale]
      redirect_to home_path
    end
    #if session[:return_to] 
    #  redirect_to session[:return_to]
    #end
  end
  
  def about
 
  end
  
end
