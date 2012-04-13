# encoding: utf-8
class PasswordController < ApplicationController
  layout "account", :only => [:recover]
  skip_before_filter :authorize #, only: [:recover_create, :recover_send]
  
  def index
    #unless params[:recover_link].blank?
      recover = PasswordRecover.find_by_link(params[:recover_link])
        unless recover.nil?
          user = recover.user
          session[:user_id] = user.id
          user.password_recovers.destroy_all
          redirect_to user_profile_path, flash: { alert: "Вы были авторизовны по одноразовой ссылке. Пожалуйста, смените Ваш пароль." }
        else
          redirect_to home_path, flash: { alert: "Ссылка восстановления не найдена." }
        end
    #end
  end

  def recover
    respond_to do |format|
      if params[:email]
        @user = User.find_by_email(params[:email])
        unless @user.nil?
          @user.password_recovers.destroy_all
          recover = @user.password_recovers.create(link: random_string)
          UserNotifier.delay.password_recover(recover)
          format.json { render json: { :status => :sended } }
          format.html { redirect_to home_path, flash: { alert: "На вашу почту отправлена ссылка. Перейдите по ней для восстановления учетной записи." } }
        else
          format.json {render json: { :status => :not_found } }
          format.html { redirect_to url_for, flash: { error: "учетная запись не найдена." } }
        end
      else
        format.html
        format.json {render json: { :status => :unprocessable_entity } }
      end
    end
  end
end
