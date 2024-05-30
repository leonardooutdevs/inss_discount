module ImagesHelper
  INSS_LOGO_URL = ENV.fetch('INSS_LOGO_URL', '')

  def logo
    tag.img src: INSS_LOGO_URL, class: 'bi me-2',
            width: '100%', height: 'auto', role: 'img', aria_label: 'Bootstrap'
  end
end
