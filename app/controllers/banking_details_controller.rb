class BankingDetailsController < ApplicationController
  # GET /banking_details
  # GET /banking_details.json
  def index
    @banking_details = BankingDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @banking_details }
    end
  end

  # GET /banking_details/1
  # GET /banking_details/1.json
  def show
    @banking_detail = BankingDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @banking_detail }
    end
  end

  # GET /banking_details/new
  # GET /banking_details/new.json
  def new
    @banking_detail = BankingDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @banking_detail }
    end
  end

  # GET /banking_details/1/edit
  def edit
    @banking_detail = BankingDetail.find(params[:id])
  end

  # POST /banking_details
  # POST /banking_details.json
  def create
    @banking_detail = BankingDetail.new(params[:banking_detail])

    respond_to do |format|
      if @banking_detail.save
        format.html { redirect_to @banking_detail, notice: 'Banking detail was successfully created.' }
        format.json { render json: @banking_detail, status: :created, location: @banking_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @banking_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /banking_details/1
  # PUT /banking_details/1.json
  def update
    @banking_detail = BankingDetail.find(params[:id])

    respond_to do |format|
      if @banking_detail.update_attributes(params[:banking_detail])
        format.html { redirect_to @banking_detail, notice: 'Banking detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @banking_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banking_details/1
  # DELETE /banking_details/1.json
  def destroy
    @banking_detail = BankingDetail.find(params[:id])
    @banking_detail.destroy

    respond_to do |format|
      format.html { redirect_to banking_details_url }
      format.json { head :no_content }
    end
  end
end
