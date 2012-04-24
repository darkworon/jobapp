# encoding: utf-8
#require 'will_paginate/array'
class SearchController < ApplicationController
  skip_before_filter :authorize
  def resume
    @content_for_title = t('search.resume.site_title')
    @page_content_description = "Поиск по ранее созданным резюме. Найдите соотрудников для своей компании."
    respond_to do |format|
      
      if params[:search]
        unless params[:search].blank?
          #search = params[:search].gsub(/\+/, " ") if params[:search]
          #search = params[:search].split("+")
          query = params[:search].split(/[\s.]/).map{|q| "*#{q}*"}.join(" & ")
          #cond_values = params[:search].split(/[\s.]/)
          @resumes = Resume.search query, :with => {status: 1, :user_status => [1,2,3]}, :field_weights => { :title => 10, :city => 4, :description => 5, career: 5}, match_mode: :extended2, rank_mode: :wordcount, :order => "list_date DESC, @relevance DESC", :page => params[:page], :per_page => 8
          #search.each do |s|
          #  @resumes += Resume.authenticated.find(:all, :conditions => ['title LIKE ?', "%#{s}%"]).paginate :per_page => 8, :page => params[:page], :order => 'list_date DESC'
          #list += @resumes
          #end
          #@resumes = Resume.authenticated.find(:all, :conditions => ['title LIKE ?', "%#{params[:search]}%"]).paginate :per_page => 8, :page => params[:page], :order => 'list_date DESC'
          format.js { render layout: false }
          format.html
        else
          @resumes = Resume.search :with => {status: 1, :user_status => [1,2,3]}, :order => "list_date DESC", :page => params[:page], :per_page => 8
          format.js { render layout: false }
          #format.json { render json: @list }
          format.html
        end
      else
        format.js { render layout: false }
        #format.json { render json: @list }
        format.html
      end
    end
  end

  def vacancy
    if request.path == search_vacancy_path
      @content_for_title = t('search.vacancy.site_title')
      @page_content_description = "Поиск по ранее созданным вакансиям. Найдите подходящую работу для себя."
    else
      @content_for_title = @site_title
    end
    respond_to do |format|
      if params[:search]
        unless params[:search].blank?
          query = params[:search].split(/[\s.]/).map{|q| "*#{q}*"}.join(" & ")
          @vacancies = Vacancy.search query, :with => {status: 1, :user_status => [1,2,3]}, :field_weights => { :title => 10, :city => 4, :description => 5, career: 5}, match_mode: :extended2, rank_mode: :wordcount, :order => "list_date DESC, @relevance DESC", :page => params[:page], :per_page => 8 #, paginate :per_page => 10, :page => params[:page] #, :order => 'list_date DESC'
          format.html
          format.js { render layout: false }
          #format.html
        else
          @vacancies = Vacancy.search :with => {status: 1, :user_status => [1,2,3]}, :order => "list_date DESC", :page => params[:page], :per_page => 8
          format.html
          format.js { render layout: false }
          #format.json { render json: @list }
        end
      else
        format.html
        #format.js { render layout: false }
        #format.json { render json: @list }
      end
    end
  end
  
  def professions_resumes
    respond_to do |format|
      #@jobs = Job.authenticated.find(:all, :conditions => ['title LIKE ?', "%#{params[:search]}%"], group: :title)
      @jobs = Resume.authenticated_prof.find(:all, conditions: ['title LIKE ?', "%#{params[:search]}%"], group: :title, :select => "title, COUNT(*) as count", order: ["count DESC", "title DESC"], limit: 12)
      @list = @jobs.map { |v| [v.title, v.count] }
      format.json { render json: @list }
    end
  end
  
  def professions_vacancies
    respond_to do |format|
      #@jobs = Job.authenticated.find(:all, :conditions => ['title LIKE ?', "%#{params[:search]}%"], group: :title)
      @jobs = Vacancy.authenticated_prof.find(:all, conditions: ['title LIKE ?', "%#{params[:search]}%"], group: :title, :select => "title, COUNT(*) as count", order: ["count DESC", "title DESC"], limit: 12)
      @list = @jobs.map { |v| [v.title, v.count] }
      format.json { render json: @list }
    end
  end
end
