module MoneyHelper
  include ActionView::Helpers::NumberHelper

  def m(val, options = { unit: 'R$ ', separator: ',', delimiter: '.' })
    number_to_currency(val.to_float, **options)
  end

  def percent(val)
    "#{(val.to_float * 100).round(2)}%"
  end
end
