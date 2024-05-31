module MoneyHelper
  def m(val, options = { unit: 'R$ ', separator: ',', delimiter: '.' })
    number_to_currency(val.to_float, **options)
  end
end
