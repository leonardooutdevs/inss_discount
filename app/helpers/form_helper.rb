module FormHelper
  INSS_LOGO_URL = ENV.fetch('INSS_LOGO_URL', '')

  def validation_class(errors)
    errors.any? ? 'is-invalid' : 'is-valid'
  end
end
