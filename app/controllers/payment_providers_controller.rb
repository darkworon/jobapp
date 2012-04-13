class PaymentProvidersController < ApplicationController
  # GET /payment_providers
  # GET /payment_providers.json
  def index
    @payment_providers = PaymentProvider.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payment_providers }
    end
  end

  # GET /payment_providers/1
  # GET /payment_providers/1.json
  def show
    @payment_provider = PaymentProvider.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment_provider }
    end
  end

  # GET /payment_providers/new
  # GET /payment_providers/new.json
  def new
    @payment_provider = PaymentProvider.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment_provider }
    end
  end

  # GET /payment_providers/1/edit
  def edit
    @payment_provider = PaymentProvider.find(params[:id])
  end

  # POST /payment_providers
  # POST /payment_providers.json
  def create
    @payment_provider = PaymentProvider.new(params[:payment_provider])

    respond_to do |format|
      if @payment_provider.save
        format.html { redirect_to @payment_provider, notice: 'Payment provider was successfully created.' }
        format.json { render json: @payment_provider, status: :created, location: @payment_provider }
      else
        format.html { render action: "new" }
        format.json { render json: @payment_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /payment_providers/1
  # PUT /payment_providers/1.json
  def update
    @payment_provider = PaymentProvider.find(params[:id])

    respond_to do |format|
      if @payment_provider.update_attributes(params[:payment_provider])
        format.html { redirect_to @payment_provider, notice: 'Payment provider was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_providers/1
  # DELETE /payment_providers/1.json
  def destroy
    @payment_provider = PaymentProvider.find(params[:id])
    @payment_provider.destroy

    respond_to do |format|
      format.html { redirect_to payment_providers_url }
      format.json { head :no_content }
    end
  end
end
