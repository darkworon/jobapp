# encoding: utf-8
class VacanciesController < ApplicationController
  include ActionView::Helpers::TextHelper
  skip_before_filter :authorize, only: [:show]
  #before_filter :user_is_activated
  # GET /vacancies
  # GET /vacancies.json
  def index
    @content_for_title = I18n.t('.vacancies.index.page_title')
    @vacancies = @current_user.vacancies.paginate(:page => params[:page], :per_page => 8, order: "created_at DESC")
    @vacancies_max = @current_user.orders.sum(:quantity_remained, joins: :pricelist, conditions: {status: 1, pricelists: {entry_type: 3}}) + Job::VACANCIES_FREE
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vacancies }
    end
  end

  # GET /vacancies/1
  # GET /vacancies/1.json
  def show
    @vacancy = Vacancy.find(params[:id])
    @content_for_title = @vacancy.title
    @page_content_description = "Требования: #{truncate(@vacancy.career.gsub(/\r/," ").gsub(/\n/,""), length: 60)}. Условия: #{truncate(@vacancy.description.gsub(/\r/," ").gsub(/\n/,""), length: 60)}"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vacancy }
    end
  end

  # GET /vacancies/new
  # GET /vacancies/new.json
  def new
   # @vacancies_max = @current_user.orders.sum(:quantity_remained, joins: :pricelist, conditions: {status: 1, pricelists: {entry_type: 3}}) + Job::VACANCIES_FREE
    unless @current_user.companies.count >= 1
      redirect_to new_company_path, flash: { info: "У вас нет ни одной компании. Пожалуйста, создайте хотя бы одну." }
      return
    end
    
    #if @current_user.vacancies.count <= 7 or @vacancies_max >= @current_user.vacancies.count
      if params[:id]
        @content_for_title = "Создание вакансии на основе существующей"
        old = Vacancy.find(params[:id]).clear_private_fields
        @vacancy = old.dup
        @vacancy.email = @current_user.email
        @vacancy.phone = @current_user.phone
        @vacancy.city = @current_user.city
        @vacancy.name = @current_user.full_name if @current_user.full_name != @current_user.email
        session[:old_job_id] = old.id
        # old.clear_private_fields# = old.clear_private_fields
      else
        @content_for_title = "Создание новой вакансии"
        session[:old_job_id] = nil
        @vacancy = Vacancy.new(user: current_user)
        @vacancy.email = @current_user.email
        @vacancy.phone = @current_user.phone
        @vacancy.city = @current_user.city
        @vacancy.name = @current_user.full_name if @current_user.full_name != @current_user.email
      end
    
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @vacancy }
      end
    #else
    #  respond_to do |format|
    #    format.html { redirect_to vacancies_path, flash: { error: "Лимит создаваемых вакансий исчерпан." }}
    #  end
    #end
  end

  # GET /vacancies/1/edit
  def edit
    @content_for_title = "Редактирование вакансии"
    @vacancy = Vacancy.find(params[:id])
    unless @current_user.is_moderator? or @vacancy.user == @current_user
      redirect_to home_path, flash: { error: "Нет прав на редактирование вакансии." }
    end
  end

  # POST /vacancies
  # POST /vacancies.json
  def create
    #@vacancies_max = @current_user.orders.sum(:quantity_remained, joins: :pricelist, conditions: {status: 1, pricelists: {entry_type: 3}}) + Job::VACANCIES_FREE
    #if @current_user.vacancies.count <= 7 or @vacancies_max >= @current_user.vacancies.count
      @vacancy = @current_user.vacancies.create(params[:vacancy])
      unless session[:old_job_id].nil?
        old = Vacancy.find(session[:old_job_id])
        @vacancy.list_date = old.list_date if old.user == @current_user
      end
      #@vacancy.email = @current_user.email if @vacancy.email.blank?
      #@vacancy.phone = @current_user.phone if @vacancy.phone.blank?
      #@vacancy.city = @current_user.city if @vacancy.city.blank?
      #@vacancy.name = @current_user.full_name if @vacancy.name.blank? and @current_user.full_name != @current_user.email
      #@vacancy.list_date = old.list_date
      #@vacancy.phone = @current_user.phone if @vacancy.phone.blank?
      #@vacancy.user = @current_user
      respond_to do |format|
        if @vacancy.save
          format.html { redirect_to vacancies_path, notice: 'Вакансия была создана. Проверьте и опубликуйте ее.' }
          format.json { render json: @vacancy, status: :created, location: @vacancy }
        else
          format.html { render action: "new" }
          format.json { render json: @vacancy.errors, status: :unprocessable_entity }
        end
      end
    #else
    #  respond_to do |format|
    #    format.html { redirect_to :back, flash: { error: "Limit of vacancies exceeded." }}
     # end
   # end
  end

  # PUT /vacancies/1
  # PUT /vacancies/1.json
  def update
    @vacancy = Vacancy.find(params[:id])
    unless @current_user.is_moderator? or @vacancy.user == @current_user
      redirect_to home_path, flash: { error: "Нет прав на редактирование вакансии." }
      return
    end
    respond_to do |format|
      if @vacancy.update_attributes(params[:vacancy])
        format.html { redirect_to vacancies_path, notice: 'Вакансия успешно обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacancies/1
  # DELETE /vacancies/1.json
  def destroy
    @vacancy = Vacancy.find(params[:id])
    unless @current_user.is_moderator? or @vacancy.user == @current_user
      redirect_to home_path, flash: { error: "Нет прав на редактирование вакансии." }
      return
    end
    @vacancy.destroy
    respond_to do |format|
      format.html { redirect_to :back, flash: {info: "Вакансия ##{@vacancy.id} удалена."} }
      format.js
      format.json { head :no_content }
    end
  end
  
  
  def priority
    unless params[:priority]
      vacancy = Vacancy.find(params[:id])
      priorities = #vacancy.priority
      respond_to do |format|
        format.json { render json: "{\"1\":1,\"2\":2,\"3\":3,\"4\":4,\"5\":5,\"6\":6,\"7\":7,\"8\":8,\"9\":9,\"10\":10,\"selected\":#{vacancy.priority}}" }#
      end
      return
    else
    new_priority = params[:priority]
    vacancy = Vacancy.find(params[:id])
    old_priority = vacancy.priority
    if vacancy.user == @current_user
      vacancy.priority = new_priority
      if vacancy.priority >= 1 and vacancy.priority <= 10
        vacancy.save
        respond_to do |format|
          format.json { render json: vacancy.priority }# { header: :ok }
        end
      else
        respond_to do |format|
          format.json { render json: old_priority }# { header: :ok }
        end
      end
    else
      respond_to do |format|
        format.json { render json: old_priority }# { header: :ok }
      end
    end
    end
  end
  
  def publish
    @vacancy = @current_user.inactive_vacancies.find(params[:id])
    @vacancies_max = @current_user.orders.sum(:quantity_remained, joins: :pricelist, conditions: {status: 1, pricelists: {entry_type: 3}}) + Job::VACANCIES_FREE
    if @current_user.vacancies.count <= 7 or @vacancies_max > @current_user.active_vacancies.count
      @vacancy = @current_user.inactive_vacancies.find(params[:id])
      @vacancy.status = 1
      @vacancy.save
      respond_to do |format|
        format.js { render :layout => false }
      end  
    else
      # не публикуем
    end
  end
  def ban
    @vacancy = Vacancy.where(status: 1, id: params[:id]).first
    unless @current_user.is_moderator?
      return
    end
    @vacancies_max = @current_user.orders.sum(:quantity_remained, joins: :pricelist, conditions: {status: 1, pricelists: {entry_type: 3}}) + Job::VACANCIES_FREE
    #if @current_user.vacancies.count <= 7 or @vacancies_max >= @current_user.active_vacancies.count
    #@vacancy = @current_user.inactive_vacancies.find(params[:id])
    @vacancy.status = -2
    if @vacancy.save
      respond_to do |format|
        format.js { render :layout => false }
      end
    end
  end
  
  def hide
    #@vacancy = @current_user.active_vacancies.find(params[:id])
    @vacancy = Vacancy.where(status: 1, id: params[:id]).first
    unless @current_user.is_moderator? or @vacancy.user == @current_user
      return
    end
    @vacancies_max = @current_user.orders.sum(:quantity_remained, joins: :pricelist, conditions: {status: 1, pricelists: {entry_type: 3}}) + Job::VACANCIES_FREE
    #if @current_user.vacancies.count <= 7 or @vacancies_max >= @current_user.active_vacancies.count
    #@vacancy = @current_user.inactive_vacancies.find(params[:id])
    @vacancy.status = 0
    if @vacancy.save
      respond_to do |format|
        format.js { render :layout => false }
      end
    end  
    #else
      # не публикуем
   # end
  end
  
  def salary
    unless params[:salary]
      vacancy = Vacancy.find(params[:id])
      respond_to do |format|
        format.json { render json: vacancy.salary }# { header: :ok }
      end
      return
    else
    new_salary = params[:salary].gsub(" ", "").gsub(/(Р|р|Р.|р.|руб|Руб|руб.|Руб.)/, "")
    vacancy = Vacancy.find(params[:id])
    old_salary = vacancy.salary
    if vacancy.user == @current_user
      vacancy.salary = new_salary
      if vacancy.salary > 0
        vacancy.save
        respond_to do |format|
          format.json { render json: ActionController::Base.helpers.number_to_currency(vacancy.salary) }# { header: :ok }
        end
      else
        respond_to do |format|
          format.json { render json: ActionController::Base.helpers.number_to_currency(old_salary) }# { header: :ok }
        end
      end
    else
      respond_to do |format|
        format.json { render json: ActionController::Base.helpers.number_to_currency(vacancy.salary) }# { header: :ok }
      end
    end
    end
  end
  
end
