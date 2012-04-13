class ModeratorController < ApplicationController
  skip_before_filter :authorize
  before_filter :user_is_moderator
  def index
  end
  def vacancies
    @vacancies = Vacancy.all.paginate :per_page => 20, :page => params[:page], :order => 'created_at DESC'
  end
  def resumes
    @resumes = Resume.all.paginate :per_page => 20, :page => params[:page], :order => 'created_at DESC'
  end
  def users
    @users = User.all.paginate :per_page => 20, :page => params[:page], :order => 'created_at DESC'
  end
end
