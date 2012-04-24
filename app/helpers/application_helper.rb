# encoding: UTF-8

module ApplicationHelper
  def page_title
    if @content_for_title
      @content_for_title
    else
      @site_title
    end
  end
  def page_content_title
    if @content_for_title and @content_for_title != @site_title
      "#{@content_for_title} - #{@site_title}"
    else
      @site_title
    end
  end
  def page_content_description
    if @page_content_description
      @page_content_description
    else
      "Первый сайт, на котором вы можете без труда найти работу или соотрудника для своей компании. При этом, вам не придется заполнять кучу бесполезных форм."
    end
  end
  def username(user)
    user.firstname.blank? ? user.email : user.firstname
  end
  def is_active?(page_name)
    "active" if params[:controller] == page_name
  end
  def is_active_ca?(controllers)
    "active" if controllers.include?(params[:controller])
  end
  def is_active_ca?(controller, action)
    "active" if params[:controller] == controller and params[:action] == action
  end
  def sub_active_c?(controllers)
    "active" if controllers.include?(params[:controller])
  end
  def sub_active_ca?(controller, action)
    "sub_nav_active" if params[:controller] == controller and params[:action] == action
  end
  def cp(path)
    "active" if current_page?(path)
  end
  def cp_sub(path)
    "sub_nav_active" if current_page?(path)
  end
  def cp_a(path)
    is_current = false
    path.each do |p|
      is_current = true if current_page?(p)
    end
    "active" if is_current
  end
  def resume_resp_count
    resume_resp_recieved_count + resume_resp_sent_count
  end
  def vacancy_resp_count
    @current_user.unreaded_sent_vacancy_responses.count + @current_user.unreaded_recieved_vacancy_responses.count
  end
  def resp_sent_count
    @current_user.unreaded_sent_resume_responses.count + @current_user.unreaded_sent_vacancy_responses.count
  end
  def resp_recieved_count
    @current_user.unreaded_recieved_resume_responses.count + @current_user.unreaded_recieved_vacancy_responses.count
  end
  def resp_count
    resp_sent_count + resp_recieved_count
  end
  
  def resume_resp_sent_count
    @current_user.unreaded_sent_resume_responses.count
  end
  
  def resume_resp_recieved_count
    @current_user.unreaded_recieved_resume_responses.count
  end
  
  def vacancy_resp_recieved_count
    @current_user.unreaded_recieved_vacancy_responses.count
  end
  
  def vacancy_resp_sent_count
    @current_user.unreaded_sent_vacancy_responses.count
  end
end
