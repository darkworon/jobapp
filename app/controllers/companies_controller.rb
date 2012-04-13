# encoding: utf-8
class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.json
  def index
    @content_for_title = "Мои компании"
    @companies = @current_user.companies.order("created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    
    @company = Company.find(params[:id])
    @content_for_title = @company.short_name
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @content_for_title = "Создание новой компании"
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @content_for_title = "Редактирование компании"
    @company = Company.find(params[:id])
    redirect_to home_path if @company.owner != @current_user
  end

  # POST /companies
  # POST /companies.json
  def create
    #@company = Company.new(params[:company])
    @company = @current_user.companies.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Компания была успешно создана.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])
    redirect_to home_path if @company.owner != @current_user
    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, notice: 'Компания успешно обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    redirect_to home_path if @company.owner != @current_user
    @company.destroy
    
    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
end
