module VacanciesHelper
  def types_of_job
      I18n.t(:types_of_job).map { |key, value| [ value, key.to_s ] }
  end
  
  def educations
      I18n.t(:educations).map { |key, value| [ value, key.to_s ] }
  end


  def experience_periods
      I18n.t('.vacancy.experience_periods').map { |key, value| [ value, key.to_s ] }
  end

  def vacancy_sexes
      I18n.t('.vacancy.sexes').map { |key, value| [ value, key.to_s ] }
  end
end
