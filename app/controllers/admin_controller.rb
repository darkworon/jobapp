class AdminController < ApplicationController
  before_filter :user_is_admin
  def index
    redirect_to moderator_path
  end
end
