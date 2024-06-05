class ProponentsController < ResourcefulController
  resourceful(
    include_nesteds: true,
    columns: %(
      proponents.id,
      proponents.name,
      document,
      gross_salary,
      discount,
      net_salary,
      cities.name as city_name,
      states.uf as state_uf
    ),
    tables: { address: { city: :state } }
  )

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
