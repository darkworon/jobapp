class UserExpencesController < ApplicationController
  # GET /user_expences
  # GET /user_expences.json
  def index
    @user_expences = UserExpence.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_expences }
    end
  end

  # GET /user_expences/1
  # GET /user_expences/1.json
  def show
    @user_expence = UserExpence.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_expence }
    end
  end

  # GET /user_expences/new
  # GET /user_expences/new.json
  def new
    @user_expence = UserExpence.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_expence }
    end
  end

  # GET /user_expences/1/edit
  def edit
    @user_expence = UserExpence.find(params[:id])
  end

  # POST /user_expences
  # POST /user_expences.json
  def create
    @user_expence = UserExpence.new(params[:user_expence])

    respond_to do |format|
      if @user_expence.save
        format.html { redirect_to @user_expence, notice: 'User expence was successfully created.' }
        format.json { render json: @user_expence, status: :created, location: @user_expence }
      else
        format.html { render action: "new" }
        format.json { render json: @user_expence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_expences/1
  # PUT /user_expences/1.json
  def update
    @user_expence = UserExpence.find(params[:id])

    respond_to do |format|
      if @user_expence.update_attributes(params[:user_expence])
        format.html { redirect_to @user_expence, notice: 'User expence was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_expence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_expences/1
  # DELETE /user_expences/1.json
  def destroy
    @user_expence = UserExpence.find(params[:id])
    @user_expence.destroy

    respond_to do |format|
      format.html { redirect_to user_expences_url }
      format.json { head :no_content }
    end
  end
end
