class PricelistsController < ApplicationController
  # GET /pricelists
  # GET /pricelists.json
  def activate
    @pricelist = Pricelist.where(id: params[:id], status: 0)
    @pricelist.status = 1
    @pricelist.save
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pricelist }
    end
  end
  def archived
    @pricelists = Pricelist.where(status: 2)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pricelists }
    end
  end
  def drafts
    @pricelists = Pricelist.where(status: 0)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pricelists }
    end
  end
  
  def index
    @pricelists = Pricelist.active

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pricelists }
    end
  end

  # GET /pricelists/1
  # GET /pricelists/1.json
  def show
    @pricelist = Pricelist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pricelist }
    end
  end

  # GET /pricelists/new
  # GET /pricelists/new.json
  def new
    @pricelist = Pricelist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pricelist }
    end
  end

  # GET /pricelists/1/edit
  def edit
    @pricelist = Pricelist.find(params[:id])
  end

  # POST /pricelists
  # POST /pricelists.json
  def create
    @pricelist = Pricelist.new(params[:pricelist])

    respond_to do |format|
      if @pricelist.save
        format.html { redirect_to @pricelist, notice: 'Pricelist was successfully created.' }
        format.json { render json: @pricelist, status: :created, location: @pricelist }
      else
        format.html { render action: "new" }
        format.json { render json: @pricelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pricelists/1
  # PUT /pricelists/1.json
  def update
    @pricelist = Pricelist.find(params[:id])

    respond_to do |format|
      if @pricelist.update_attributes(params[:pricelist])
        format.html { redirect_to @pricelist, notice: 'Pricelist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pricelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pricelists/1
  # DELETE /pricelists/1.json
  def destroy
    @pricelist = Pricelist.find(params[:id])
    @pricelist.destroy

    respond_to do |format|
      format.html { redirect_to pricelists_url }
      format.json { head :no_content }
    end
  end
end
