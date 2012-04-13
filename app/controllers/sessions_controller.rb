#encoding: utf-8
class SessionsController < ApplicationController
  layout "account"
  skip_before_filter :authorize
  def new
    @content_for_title = t('sessions.new.title')
    respond_to do |format|
      format.html
      format.js
      if @current_user
        user = User.find(session[:user_id])
        format.html { redirect_to home_path, flash: { info: t('.flash.already_logged_in_as', email: user.email) }}
      end
    end
      
  end

  def create
    if @current_user
      redirect_to home_path, notice: "Вы уже авторизованы."
      return
    end
    respond_to do |format|
      user = User.find_by_email(params[:email])
      if user and user.authenticate(params[:password])
        session[:user_id] = user.id
        @current_user = user
        if params[:back_url]
          format.html { redirect_to params[:back_url] }
      #  redirect_to session[:return_to]
      #  or we can do it throught flash[:back_url]
      #  session[:return_to] = nil
        else
          format.js {render layout: false }
          format.html { redirect_to home_path, notice: t('.flash.logged_in_as', email: user.email) }
        end
      else
      #flash.now[:error] = "invalid email/password combination."
        format.js
        format.html { redirect_to login_url(back_url: params[:back_url]), :flash => { :error => "Неверная комбинация email/пароля." } } #t('.flash.invalid_combination')
      end
    end
  end

  def destroy
    respond_to do |format|
      session[:user_id] = nil
      @current_user = false
      format.js { render layout: false }
      format.html { redirect_to home_path, notice: t('.flash.logged_out') }
    end
  end

end
