module FlashMessageHelper
  KINDS = {
    notice: 'success',
    alert: 'danger',
    info: 'primary',
    warn: 'warning'
  }.with_indifferent_access.freeze

  def flash_messages
    html = ''
    flash.each do |key, value|
      html += content_tag(:div, class: "alert alert-#{KINDS[key]} alert-dismissible fade show", role: 'alert') do
        content_message(value)
      end
    end

    html.try(:html_safe)
  end

  private

  def content_message(value)
    concat(value)
    concat(
      content_tag(
        :button, '',
        type: 'button',
        class: 'btn-close', 'data-bs-dismiss': 'alert', 'aria-label': 'Close'
      )
    )
  end
end
