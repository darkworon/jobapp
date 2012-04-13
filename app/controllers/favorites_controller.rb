# encoding: utf-8
class FavoritesController < ApplicationController
  # GET /favorites
  # GET /favorites.json
  def resumes
    @content_for_title = "Избранные резюме"
    @resumes = Resume.all(joins: :favorites, conditions: { status: 1, favorites: { user_id: @current_user }})
    resumes_selected = params[:resumes_sel]
    unless resumes_selected.blank?
      email = params[:email]
      list = Resume.find(resumes_selected)
      flash.now[:info] = "Список отмеченных резюме был отправлен на #{params[:email]}."
      UserNotifier.delay.resumes_list(email, @current_user, list, I18n.locale)
    end
      respond_to do |format|
        format.html
        format.json { render json: @resumes }
      end
  end
  
  
  def vacancies
    @content_for_title = "Избранные вакансии"
    @vacancies = Vacancy.all(joins: :favorites, conditions: { status: 1, favorites: { user_id: @current_user }})
    vacancies_selected = params[:vacancies_sel]
    unless vacancies_selected.blank?
      email = params[:email]
      list = Vacancy.find(vacancies_selected)
      flash.now[:info] = "Список отмеченных вакансий был отправлен на #{params[:email]}."
      UserNotifier.delay.vacancies_list(email, @current_user, list)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vacancies }
    end
  end
    
  def add
    job = Job.find(params[:id])
    if job
      if @current_user.favorites.find_by_job_id(job).nil?
        @favorite = @current_user.favorites.create(job: job)
        respond_to do |format|
          #format.html # index.html.erb
          format.json { render json: @favorite }
          format.js { render locals: { user: @current_user, job: job, favorite: @favorite } }
        end
      end
    end
  end
  
  def remove
    job = Job.find(params[:id])
    if job
      unless @current_user.favorites.find_by_job_id(job).nil?
        @favorite = @current_user.favorites.where(job_id: job).first.destroy
        respond_to do |format|
          #format.html # index.html.erb
          format.json { render json: @favorite }
          format.js { render locals: { user: @current_user, job: job } }
        end
      end
    end
  end
  
  
end
