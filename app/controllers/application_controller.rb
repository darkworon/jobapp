# encoding: utf-8
require 'digest/sha1'
class ApplicationController < ActionController::Base
  before_filter :set_locale
  before_filter :authorize
  before_filter :register_globals
  before_filter :check_user_not_banned
  before_filter :check_user_is_activated
  before_filter :set_user_time_zone
  #before_filter :check_locale_parameter
  protect_from_forgery
  
private
  def register_globals
    @current_user = current_user
    @site_title_base = "Job4Fun"
    @site_header = "<span>Job</span>4<span>Fun</span>"
    @site_title = @site_title_base
  end
  
  
  def current_user
    unless session[:user_id].nil?
      User.find(session[:user_id])
    else
      false
    end
  end
  
  def set_user_time_zone
    Time.zone = @current_user.time_zone if @current_user
  end
protected
   # def set_i18n_locale_from_params
  #      if params[:locale]
  #        if I18n.available_locales.include?(params[:locale].to_sym)
  #          I18n.locale = params[:locale]
  #          session[:locale] = params[:locale]
  #          cookies.permanent[:locale_set] = params[:locale]
  #        else
  #          if session[:locale]
  #            #params[:locale] = session[:locale]
  #            #I18n.locale = session[:locale]
  #            #locale_redirect(session[:locale])
  #            #redirect_to request.url  #, notice: "Translation \"#{params[:locale]}\" not available."
  #            #logger.error flash.now[:notice]
  #            redirect_to url_for(locale: session[:locale])
  #          elsif cookies[:locale_set]
  #            session[:locale] = cookies[:locale_set]
  #            params[:locale] = cookies[:locale_set]
  #            I18n.locale = cookies[:locale_set]
  #            #locale_redirect(session[:locale])
  #         else
  #            locale = get_best_locale
  #            params[:locale] = locale
  #            session[:locale] = locale
  #            cookies.permanent[:locale_set] = locale
  #            I18n.locale = locale
  #            #locale_redirect(I18n.locale)
  #          end
  #        end
  #      elsif session[:locale]
  #        #I18n.locale = session[:locale]
  #        redirect_to url_for(locale: session[:locale]), :status => :moved_permanently
  #      elsif cookies[:locale_set]
  #        #I18n.locale = cookies[:locale_set]
  #        redirect_to url_for(locale: cookies[:locale_set]), :status => :moved_permanently
  #      else
          #I18n.locale = get_best_locale
  #        redirect_to url_for(locale: get_best_locale), :status => :moved_permanently
  #      end
  #    end

     # def default_locale
     #   { locale: I18n.locale }
     # end
      
#      def check_locale_parameter
#        if session[:locale]
#          #if params[:locale]
#            if I18n.available_locales.include?(params[:locale].to_sym)
#             if params[:locale] != session[:locale]
#                session[:locale] = params[:locale]
#                I18n.locale = params[:locale]
#              else
#                I18n.locale = session[:locale]
#              end
#            else
#              I18n.locale = session[:locale]
#              redirect_to home_path, notice: :wrong_locale #"Translation \"#{params[:locale]}\" not available yet."
#            end
#          else
#            I18n.locale = session[:locale]
#            #redirect_to request.url, locale: I18n.locale
#          end
#        #else
#         # session[:locale] = I18n.locale
#        #end
#      end
      
      
      def set_locale
        if params[:locale]
          if I18n.available_locales.include?(params[:locale].to_sym)
            session[:locale] = params[:locale]
            cookies[:locale_set] = params[:locale]
            I18n.locale = params[:locale]
          else
            I18n.locale = get_best_locale
          end
        elsif session[:locale] or cookies[:locale_set]
          if session[:locale]
            I18n.locale = session[:locale]
          else
            I18n.locale = cookies[:locale_set]
          end
        else
          best_locale = get_best_locale
          session[:locale] = best_locale
          cookies[:locale_set] = best_locale
          I18n.locale = best_locale
        end
      end
        
      def get_best_locale
        unless request.env['HTTP_ACCEPT_LANGUAGE'].nil?
          locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first.to_sym
          if I18n.available_locales.include?(locale)
            locale
          else
            I18n.default_locale
          end
        else
          I18n.default_locale
        end
      end

    def authorize
      unless User.find_by_id(session[:user_id])
        respond_to do |format|
        #session[:return_to] = request.url
        #params[:back_url] = request.path
          format.js { render partial: "sessions/login", layout: false}
          format.html { redirect_to login_url(back_url: request.url), flash: { alert: t(".flash.please_log_in"), back_url: request.url } }
        end
      end
    end
    
    
    def user_is_admin
      if @current_user.status < 3
        #raise("not found")
        render :text => '404 - Not Found', :status => '404'
      end
    end
    
    def user_is_moderator
      if @current_user
        if @current_user.status < 2
          #raise("not found")
          render :text => '404 - Not Found', :status => '404'
        end
      else
        render :text => '404 - Not Found', :status => '404'
      #elsif @current_user.status == 3
      #  redirect_to admin_path
      end
    end
    
    def user_is_activated
      if @current_user and @current_user.status >= 1
        true
      else
        redirect_to home_path, notice: "Please, activate your account."
        #false
      end
    end
    
    def check_user_not_banned
      flash.now[:error] = "Вы забанены. Ваши вакансии и резюме были скрыты из поиска." if @current_user and @current_user.is_banned?
    end
    
    def check_user_is_activated
      flash.now[:info] = "#{I18n.t(".global.not_activated_msg")}<br />#{view_context.link_to I18n.t('.global.resend_activation_link'), resend_activation_path, class: "resend_act_email", remote: true}".html_safe if @current_user and !@current_user.is_activated?
    end
    
    def random_string
      Digest::SHA1.hexdigest Time.now.to_s
    end
    
end
