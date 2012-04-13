module JobsHelper
  def job_entry_types
      I18n.t(:job_entry_types).map { |key, value| [ value, key.to_s ] }
  end
end
