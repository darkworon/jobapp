# encoding: utf-8
class ActivationsController < ApplicationController
  skip_before_filter :authorize, only: :index
  def index
    activation = Activation.find_by_link(params[:act_link])
  #  unless @current_user
      if activation and !activation.nil?
        activation.user.status = 1
        if activation.user.save
          redirect_to home_path, notice: "#{activation.user.email} успешно активирован."
          activation.destroy
        else
          redirect_to home_path, notice: "Ошибка активации. Попробуйте еще раз."
        end
      else
        redirect_to home_path, flash: { error: "Ссылка активации не найдена." }
      end
    #else
    #  redirect_to home_path, notice: "You already logged in."
    #end
  end
  
  def resend
    respond_to do |format|
      #if @current_user
        unless @current_user.is_activated?
          @current_user.activations.destroy_all
          @current_user.activations.create(link: random_string)
          UserNotifier.signup(@current_user.activations.first).deliver
          format.js
          unless request.env['HTTP_REFERER'].blank?
            format.html { redirect_to :back, notice: "Ссылка активации была выслана заново." }
          else
            format.html { redirect_to home_path, notice: "Ссылка активации была выслана заново." }
          end
        else
          format.html { redirect_to home_path, flash: { info: "Ваш аккаунт уже активирован." }}
        end
      #else
      #    format.html { redirect_to home_path, flash: { info: "Пожалуйста, авторизуйтесь." }}
      #end
    end
  end
end
