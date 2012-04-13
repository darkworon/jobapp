module VacancyResponsesHelper
  def statuses
      I18n.t('.vacancy.response.statuses').map { |key, value| [ value, key.to_s ] }
  end
end
