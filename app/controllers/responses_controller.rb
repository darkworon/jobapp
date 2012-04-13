class ResponsesController < ApplicationController
  def index
    @resume_responses = @current_user.unreaded_recieved_resume_responses
    @vacancy_responses = @current_user.unreaded_recieved_vacancy_responses
  end
end
