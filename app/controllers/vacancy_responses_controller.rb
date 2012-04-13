#encoding: utf-8
class VacancyResponsesController < ApplicationController
  # GET /vacancy_responses
  # GET /vacancy_responses.json
  def index
    @vacancy_responses_sent = @current_user.sent_vacancy_responses.find(:all, :order => 'created_at DESC')
    @vacancy_responses_recieved = @current_user.recieved_vacancy_responses.find(:all, :order => 'created_at DESC')
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vacancy_responses }
    end
  end
  
  def accept
    @vacancy_response = VacancyResponse.where(id: params[:id], recipient_id: @current_user, status: [0,1,3]).first
    return redirect_to home_path, flash: {error: "Доступ запрещен."} if @vacancy_response.nil?
    @vacancy_response.viewed_by_recipient = true
    @vacancy_response.viewed_by_sender = false
    @vacancy_response.status = 2
    @vacancy_response.save
    redirect_to vacancy_responses_path, notice: "Отклик ##{@vacancy_response.id} принят. Отправившему отклик было выслано уведомление."
  end
  
  
  def ok
    @vacancy_response = VacancyResponse.where(id: params[:id], sender_id: @current_user, viewed_by_sender: false, status: [2,3]).first
    @vacancy_response.viewed_by_sender = true
    if @vacancy_response.save
      redirect_to :back
    else
      return
    end
  end
  
  def decline
    @vacancy_response = VacancyResponse.where(id: params[:id], recipient_id: @current_user, status: [0,1,2]).first
    return redirect_to home_path, flash: {error: "Доступ запрещен."} if @vacancy_response.nil?
    @vacancy_response.viewed_by_recipient = true
    @vacancy_response.viewed_by_sender = false
    @vacancy_response.status = 3
    @vacancy_response.save
    redirect_to vacancy_responses_path, notice: "Отклик ##{@vacancy_response.id} отклонен."
  end
  # GET /vacancy_responses/1
  # GET /vacancy_responses/1.json
  #def show
  #  @vacancy_response = VacancyResponse.where(id: params[:id], recipient_id: @current_user, status: [0,1]).first
  #  return redirect_to home_path, flash: {error: "Доступ запрещен."} if @vacancy_response.nil?
  #  
  #  @vacancy_response.status = 1
  #  @vacancy_response.viewed_by_recipient = true
  #  @vacancy_response.save
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.json { render json: @vacancy_response }
  #  end
  #end

  # GET /vacancy_responses/new
  # GET /vacancy_responses/new.json
  def new
    @vacancy_response = VacancyResponse.new
    @vacancy = Vacancy.find(params[:id])
    return redirect_to home_path, flash: {error: "Вы не можете откликнуться на собственную вакансию" } if @vacancy.user == @current_user
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vacancy_response }
    end
  end

  # GET /vacancy_responses/1/edit
  def edit
    @vacancy_response = VacancyResponse.find(params[:id])
  end

  # POST /vacancy_responses
  # POST /vacancy_responses.json
  def create
    @vacancy_response = VacancyResponse.new(params[:vacancy_response])
    @vacancy = Vacancy.find(params[:id])
    @vacancy_response.vacancy = @vacancy
    @vacancy_response.sender = @current_user
    @vacancy_response.recipient = @vacancy.user
    respond_to do |format|
      if @vacancy_response.save
        format.html { redirect_to home_path, notice: 'Отклик на вакансию был отправлен.' }
        format.json { render json: @vacancy_response, status: :created, location: @vacancy_response }
      else
        format.html { render action: "new" }
        format.json { render json: @vacancy_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vacancy_responses/1
  # PUT /vacancy_responses/1.json
  def update
    @vacancy_response = VacancyResponse.find(params[:id])

    respond_to do |format|
      if @vacancy_response.update_attributes(params[:vacancy_response])
        format.html
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vacancy_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacancy_responses/1
  # DELETE /vacancy_responses/1.json
  def destroy
    @vacancy_response = VacancyResponse.find(params[:id])
    @vacancy_response.destroy

    respond_to do |format|
      format.html { redirect_to vacancy_responses_url }
      format.json { head :no_content }
    end
  end
end
