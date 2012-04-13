class StatusController < ApplicationController
  skip_before_filter :authorize
  def check
    respond_to do |format|
      if @current_user
        format.json { render json: { status: @current_user.status } }
        if @current_user.status == 0
          format.js { render locals: { user: @current_user } }
          format.html
        end
      else
        format.json { render json: { status: -2 } }
      end
    end
  end
end
