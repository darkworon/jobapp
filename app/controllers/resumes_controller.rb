# encoding: utf-8
class ResumesController < ApplicationController
  include ActionView::Helpers::TextHelper
  #before_filter :user_is_activated
  skip_before_filter :authorize, only: :priority
  # GET /resumes
  # GET /resumes.json
  def index
    @content_for_title = "Мои резюме"
    @resumes = @current_user.resumes.paginate(:page => params[:page], :per_page => 8, order: "created_at DESC")
    @resumes_max = @current_user.orders.sum(:quantity_remained, joins: :pricelist, conditions: {status: 1, pricelists: {entry_type: 4}}) + Job::RESUMES_FREE
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resumes }
    end
  end

  # GET /resumes/1
  # GET /resumes/1.json
  def show
    @resume = Resume.find(params[:id])
    @content_for_title = @resume.title
    @page_content_description = "Карьера: #{truncate(@resume.career.gsub(/\r/," ").gsub(/\n/,""), length: 50)}. Навыки и знания: #{truncate(@resume.description.gsub(/\r/," ").gsub(/\n/,""), length: 50)}"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resume }
    end
  end

  # GET /resumes/new
  # GET /resumes/new.json
  def new
    #@resumes_max = @current_user.orders.sum(:quantity_remained, joins: :pricelist, conditions: {status: 1, pricelists: {entry_type: 4}}) + Job::RESUMES_FREE
    #subscriptions = @current_user.orders.find(:all, )
    #if @current_user.resumes.count <= 3 or @resumes_max >= @current_user.resumes.count
      if params[:id]
        @content_for_title = "Создание резюме на основе существующего"
        old = Resume.find(params[:id]).clear_private_fields
        @resume = old.dup
        session[:old_job_id] = old.id
        
        # old.clear_private_fields# = old.clear_private_fields
      else
        @content_for_title = "Создание нового резюме"
        @resume = Resume.new
        session[:old_job_id] = nil
      end
      @resume.email = @current_user.email
      @resume.phone = @current_user.phone
      @resume.city = @current_user.city
      @resume.name = @current_user.full_name if @current_user.full_name != @current_user.email
      @resume.birthdate = I18n.l @current_user.birthdate unless @current_user.birthdate.blank? rescue ""
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @resume }
      end
    #else
    #  respond_to do |format|
    #    format.html { redirect_to :back, flash: { error: "Limit of resumes exceeded." }}
    #  end
    #end
  end

  # GET /resumes/1/edit
  def edit
    @content_for_title = "Редактирование резюме"
    @resume = Resume.find(params[:id])
    @resume.birthdate = I18n.l @resume.birthdate rescue ""
    unless @current_user.is_moderator? or @resume.user == @current_user
      redirect_to home_path, flash: { error: "У вас нет прав для редактирования этого резюме." }
    end
  end

  # POST /resumes
  # POST /resumes.json
  def create
   #@resumes_max = @current_user.orders.sum(:quantity_remained, joins: :pricelist, conditions: {status: 1, pricelists: {entry_type: 4}}) + Job::RESUMES_FREE
    #subscriptions = @current_user.orders.find(:all, )
    #if @current_user.resumes.count <= 3 or @resumes_max >= @current_user.resumes.count
      #@resume = Resume.new(params[:resume])
      @resume = @current_user.resumes.create(params[:resume])
      unless session[:old_job_id].nil?
        old = Resume.find(session[:old_job_id])
        @resume.list_date = old.list_date if old.user == @current_user
      end
      #@resume.user = @current_user
      respond_to do |format|
        if @resume.save
          format.html { redirect_to resumes_path, flash: { info: 'Резюме было успешно создано. Проверьте и опубликуйте его.' } }
          format.json { render json: @resume, status: :created, location: @resume }
        else
          format.html { render action: "new" }
          format.json { render json: @resume.errors, status: :unprocessable_entity }
        end
      end
    #else
    #  respond_to do |format|
    #    format.html { redirect_to :back, flash: { error: "Limit of resumes exceeded." }}
    #  end
    #end
  end

  # PUT /resumes/1
  # PUT /resumes/1.json
  def update
    @resume = Resume.find(params[:id])
    unless @current_user.is_moderator? or @resume.user == @current_user
      redirect_to home_path, flash: { error: "Нет прав на редактирование." }
      return
    end
    respond_to do |format|
      if @resume.update_attributes(params[:resume])
        format.html { redirect_to @resume, notice: 'Резюме успешно обновлено.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.json
  def destroy
    @resume = Resume.find(params[:id])
    unless @current_user.is_moderator? or @resume.user == @current_user
      redirect_to home_path, flash: { error: "Не хватает прав на удаление резюме." }
      return
    end
    @resume.destroy

    respond_to do |format|
      format.html { redirect_to :back, flash: {info: "Резюме ##{@resume.id} успешно удалено."} }
      format.js
      format.json { head :no_content }
    end
  end
  
  def priority
    unless params[:priority]
      resume = Resume.find(params[:id])

      respond_to do |format|
        #format.json { render json: priorities }
        format.json { render json: "{\"1\":1,\"2\":2,\"3\":3,\"4\":4,\"5\":5,\"6\":6,\"7\":7,\"8\":8,\"9\":9,\"10\":10,\"selected\":#{resume.priority}}"  }# { header: :ok }
      end
      return
    else
    new_priority = params[:priority]
    resume = Resume.find(params[:id])
    old_priority = resume.priority
    if resume.user == @current_user
      resume.priority = new_priority
      if resume.priority >= 1 and resume.priority <= 10
        resume.save
        respond_to do |format|
          format.json { render layout: false, json: resume.priority }# { header: :ok }
        end
      else
        respond_to do |format|
          format.json { render layout: false, json: old_priority }# { header: :ok }
        end
      end
    else
      respond_to do |format|
        format.json { render layout: false, json: old_priority }# { header: :ok }
      end
    end
    end
  end
  
  def publish
    @resume = @current_user.inactive_resumes.find(params[:id])
    @resumes_max = @current_user.orders.sum(:quantity_remained, joins: :pricelist, conditions: {status: 1, pricelists: {entry_type: 4}}) + Job::RESUMES_FREE
    if @current_user.resumes.count <= 3 or @resumes_max > @current_user.active_resumes.count
      @resume = @current_user.inactive_resumes.find(params[:id])
      @resume.status = 1
      @resume.save
      respond_to do |format|
        format.js
      end  
    else
      # не публикуем
    end
  end
  
  def hide
    @resume = @current_user.active_resumes.find(params[:id])
    @resumes_max = @current_user.orders.sum(:quantity_remained, joins: :pricelist, conditions: {status: 1, pricelists: {entry_type: 4}}) + Job::RESUMES_FREE
    #if @current_user.resumes.count <= 7 or @resumes_max >= @current_user.active_resumes.count
    #@resume = @current_user.inactive_resumes.find(params[:id])
    @resume.status = 0
    if @resume.save
      respond_to do |format|
        format.js
      end
    end  
    #else
      # не публикуем
   # end
  end
  
  def salary
    unless params[:salary]
      resume = Resume.find(params[:id])
      respond_to do |format|
        format.json { render json: resume.salary }# { header: :ok }
      end
      return
    else
    new_salary = params[:salary].gsub(" ", "").gsub(/(Р|р|Р.|р.|руб|Руб|руб.|Руб.)/, "")
    resume = Resume.find(params[:id])
    old_salary = resume.salary
    if resume.user == @current_user
      resume.salary = new_salary
      if resume.salary > 0
        resume.save
        respond_to do |format|
          format.json { render json: ActionController::Base.helpers.number_to_currency(resume.salary) }# { header: :ok }
        end
      else
        respond_to do |format|
          format.json { render json: ActionController::Base.helpers.number_to_currency(old_salary) }# { header: :ok }
        end
      end
    else
      respond_to do |format|
        format.json { render json: ActionController::Base.helpers.number_to_currency(resume.salary) }# { header: :ok }
      end
    end
    end
  end
  
end
