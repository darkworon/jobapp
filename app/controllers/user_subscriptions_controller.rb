class UserSubscriptionsController < ApplicationController
  # GET /user_subscriptions
  # GET /user_subscriptions.json
  def index
    @user_subscriptions = UserSubscription.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_subscriptions }
    end
  end

  # GET /user_subscriptions/1
  # GET /user_subscriptions/1.json
  def show
    @user_subscription = UserSubscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_subscription }
    end
  end

  # GET /user_subscriptions/new
  # GET /user_subscriptions/new.json
  def new
    @user_subscription = UserSubscription.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_subscription }
    end
  end

  # GET /user_subscriptions/1/edit
  def edit
    @user_subscription = UserSubscription.find(params[:id])
  end

  # POST /user_subscriptions
  # POST /user_subscriptions.json
  def create
    @user_subscription = UserSubscription.new(params[:user_subscription])

    respond_to do |format|
      if @user_subscription.save
        format.html { redirect_to @user_subscription, notice: 'User subscription was successfully created.' }
        format.json { render json: @user_subscription, status: :created, location: @user_subscription }
      else
        format.html { render action: "new" }
        format.json { render json: @user_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_subscriptions/1
  # PUT /user_subscriptions/1.json
  def update
    @user_subscription = UserSubscription.find(params[:id])

    respond_to do |format|
      if @user_subscription.update_attributes(params[:user_subscription])
        format.html { redirect_to @user_subscription, notice: 'User subscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_subscriptions/1
  # DELETE /user_subscriptions/1.json
  def destroy
    @user_subscription = UserSubscription.find(params[:id])
    @user_subscription.destroy

    respond_to do |format|
      format.html { redirect_to user_subscriptions_url }
      format.json { head :no_content }
    end
  end
end
