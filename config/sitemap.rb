require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://job4fun.ru'
#SitemapGenerator::Sitemap.sitemaps_host = "http://job4fun.ru"
SitemapGenerator::Sitemap.create do
  #add '/ru/catalog/resumes', :changefreq => 'daily', :priority => 1
  #add '/ru/catalog/vacancies', :changefreq => 'daily', :priority => 1
  Vacancy.authenticated.each do |v|
    add vacancy_path(id: v.id)
  end
  Resume.authenticated.each do |r|
    add resume_path(id: r.id)
  end
end
SitemapGenerator::Sitemap.ping_search_engines # called for you when you use the rake task