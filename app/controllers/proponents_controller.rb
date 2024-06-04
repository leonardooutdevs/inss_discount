class ProponentsController < ApplicationController
  include Resourceful

  private

  def permitted_params
    params.require(:proponent).permit(
      :gross_salary, :name, :document, :birth_date, :address_id, :phone_id,
      proponent_addresses_attributes: [
        :id, :kind, :_destroy, { address_attributes: %i[id city_id address number complement neighborhood zip_code] }
      ],
      proponent_phones_attributes: [:id, :kind, :_destroy, { phone_attributes: %i[id number] }]
    )
  end
end
