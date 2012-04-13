#encoding: utf-8
class ResumeResponsesController < ApplicationController
  # GET /resume_responses
  # GET /resume_responses.json
  def index
    @resume_responses_sent = @current_user.sent_resume_responses.find(:all, :order => 'created_at DESC')
    @resume_responses_recieved = @current_user.recieved_resume_responses.find(:all, :order => 'created_at DESC')
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resume_responses }
    end
  end
  
  def accept
    @resume_response = ResumeResponse.where(id: params[:id], recipient_id: @current_user, status: [0,1,3]).first
    return redirect_to home_path, flash: {error: "Доступ запрещен."} if @resume_response.nil?
    @resume_response.viewed_by_recipient = true
    @resume_response.viewed_by_sender = false
    @resume_response.status = 2
    @resume_response.save
    redirect_to resume_responses_path, notice: "Отклик ##{@resume_response.id} принят. Отправившему отклик было выслано уведомление."
  end
  
  
  def ok
    @resume_response = ResumeResponse.where(id: params[:id], sender_id: @current_user, viewed_by_sender: false, status: [2,3]).first
    @resume_response.viewed_by_sender = true
    if @resume_response.save
      redirect_to :back
    else
      return
    end
  end
  
  def decline
    @resume_response = ResumeResponse.where(id: params[:id], recipient_id: @current_user, status: [0,1,2]).first
    return redirect_to home_path, flash: {error: "Доступ запрещен."} if @resume_response.nil?
    @resume_response.viewed_by_recipient = true
    @resume_response.viewed_by_sender = false
    @resume_response.status = 3
    @resume_response.save
    redirect_to resume_responses_path, notice: "Отклик ##{@resume_response.id} отклонен."
  end
  # GET /resume_responses/1
  # GET /resume_responses/1.json
  #def show
  #  @resume_response = ResumeResponse.where(id: params[:id], recipient_id: @current_user, status: [0,1]).first
  #  return redirect_to home_path, flash: {error: "Доступ запрещен."} if @resume_response.nil?
  #  
  #  @resume_response.status = 1
  #  @resume_response.viewed_by_recipient = true
  #  @resume_response.save
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.json { render json: @resume_response }
  #  end
  #end

  # GET /resume_responses/new
  # GET /resume_responses/new.json
  def new
    @resume_response = ResumeResponse.new
    @resume = Resume.find(params[:id])
    return redirect_to home_path, flash: {error: "Вы не можете откликнуться на собственное резюме" } if @resume.user == @current_user
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resume_response }
    end
  end

  # GET /resume_responses/1/edit
  def edit
    @resume_response = ResumeResponse.find(params[:id])
  end

  # POST /resume_responses
  # POST /resume_responses.json
  def create
    @resume_response = ResumeResponse.new(params[:resume_response])
    @resume = Resume.find(params[:id])
    @resume_response.resume = @resume
    @resume_response.sender = @current_user
    @resume_response.recipient = @resume.user
    respond_to do |format|
      if @resume_response.save
        format.html { redirect_to home_path, notice: 'Отклик на резюме отправлен.' }
        format.json { render json: @resume_response, status: :created, location: @resume_response }
      else
        format.html { render action: "new" }
        format.json { render json: @resume_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /resume_responses/1
  # PUT /resume_responses/1.json
  def update
    @resume_response = ResumeResponse.find(params[:id])

    respond_to do |format|
      if @resume_response.update_attributes(params[:resume_response])
        format.html { redirect_to @resume_response, notice: 'Resume response was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resume_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resume_responses/1
  # DELETE /resume_responses/1.json
  def destroy
    @resume_response = ResumeResponse.find(params[:id])
    @resume_response.destroy

    respond_to do |format|
      format.html { redirect_to resume_responses_url }
      format.json { head :no_content }
    end
  end
end
