# encoding: utf-8

class CatalogController < ApplicationController
  skip_before_filter :authorize
  def vacancies
    @content_for_title = "Каталог вакансий"
    @vacancies = Vacancy.authenticated.paginate(:page => params[:page], :per_page => 10)
  end
  def resumes
    @content_for_title = "Каталог резюме"
    @resumes = Resume.authenticated.paginate(:page => params[:page], :per_page => 10)
  end
  def companies
    @content_for_title = "Каталог копаний"
    @companies = Company.authenticated.paginate(:page => params[:page], :per_page => 10)
  end
end
