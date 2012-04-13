module ResumesHelper
  def resume_sexes
      I18n.t('.resume.sexes').map { |key, value| [ value, key.to_s ] }
  end
end
