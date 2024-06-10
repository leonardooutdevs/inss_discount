class ProponentDecorator < ApplicationDecorator
  def city_uf
    "#{proponent.city_name} - #{proponent.state_uf}"
  end
end
