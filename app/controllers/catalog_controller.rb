# encoding: utf-8
class CatalogController < ApplicationController
  def vacancies
    @content_for_title = "Каталог вакансий"
    @vacancies = Vacancy.authenticated.paginate(:page => params[:page], :per_page => 10)
  end
  def resumes
    @content_for_title = "Каталог резюме"
    @resumes = Resume.authenticated.paginate(:page => params[:page], :per_page => 10)
  end
end
