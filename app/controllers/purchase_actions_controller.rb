class PurchaseActionsController < ApplicationController
  # GET /purchase_actions
  # GET /purchase_actions.json
  def index
    @purchase_actions = PurchaseAction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @purchase_actions }
    end
  end

  # GET /purchase_actions/1
  # GET /purchase_actions/1.json
  def show
    @purchase_action = PurchaseAction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @purchase_action }
    end
  end

  # GET /purchase_actions/new
  # GET /purchase_actions/new.json
  def new
    @purchase_action = PurchaseAction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @purchase_action }
    end
  end

  # GET /purchase_actions/1/edit
  def edit
    @purchase_action = PurchaseAction.find(params[:id])
  end

  # POST /purchase_actions
  # POST /purchase_actions.json
  def create
    @purchase_action = PurchaseAction.new(params[:purchase_action])

    respond_to do |format|
      if @purchase_action.save
        format.html { redirect_to @purchase_action, notice: 'Purchase action was successfully created.' }
        format.json { render json: @purchase_action, status: :created, location: @purchase_action }
      else
        format.html { render action: "new" }
        format.json { render json: @purchase_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /purchase_actions/1
  # PUT /purchase_actions/1.json
  def update
    @purchase_action = PurchaseAction.find(params[:id])

    respond_to do |format|
      if @purchase_action.update_attributes(params[:purchase_action])
        format.html { redirect_to @purchase_action, notice: 'Purchase action was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @purchase_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_actions/1
  # DELETE /purchase_actions/1.json
  def destroy
    @purchase_action = PurchaseAction.find(params[:id])
    @purchase_action.destroy

    respond_to do |format|
      format.html { redirect_to purchase_actions_url }
      format.json { head :no_content }
    end
  end
end
