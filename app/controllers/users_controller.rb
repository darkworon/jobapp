# encoding: utf-8
class UsersController < ApplicationController
  layout "account", :only => [:new, :create]
  skip_before_filter :authorize, only: [:create, :new, :edit, :update]
  before_filter :user_is_moderator, only: [:edit, :update]
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @content_for_title = t('users.new.title')
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
      format.js
    end
  end

  # GET /users/1/edit
  def profile
    @content_for_title = "Редактирование профиля"
    @user = User.find(@current_user)
    @user.birthdate = I18n.l @user.birthdate rescue ""
  end
  
  def edit
    if @current_user.is_moderator?
      @user = User.find(params[:id])
    else
      redirect_to home_path, flash: {error: ""}
    end
  end

  # POST /users
  # POST /users.json
  def create
    @content_for_title = t('users.new.title')
    @user = User.new(params[:user])
    respond_to do |format|
      if verify_recaptcha(:model => @user) and @user.save
        #@user.authenticate(params[:password])
        #if params[:back_url]
        #  format.html { redirect_to params[:back_url] }
        #else
        @user.activations.create(link: random_string)
        UserNotifier.delay.signup(@user.activations.first)
        session[:user_id] = @user.id
        unless params[:back_url].blank?
          format.html { redirect_to params[:back_url] }
        else
          format.html { redirect_to home_path }
        end
        #end
        format.json { render json: @user, status: :created, location: @user }
        
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update_profile
    @user = User.find(@current_user)
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to :back, notice: 'Профиль успешно обновлен.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to moderator_users_path, notice: 'Профиль юзера успешно обновлен.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def subscriptions
    #@subscriptions = @current_user.orders.find(:all, order: "created_at DESC")
    @subscriptions = @current_user.orders.find(:all, joins: :pricelist, conditions: {pricelists: {entry_type: [3,4]}}, order: "created_at DESC")
  end
  

  # DELETE /users/1
  # DELETE /users/1.json
 # def destroy
 #   @user = User.find(params[:id])
  #  @user.destroy

 #   respond_to do |format|
 #     format.html { redirect_to users_url }
 #     format.json { head :no_content }
  #  end
 # end
end
