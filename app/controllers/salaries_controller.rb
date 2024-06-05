class SalariesController < ResourcefulController
  resourceful

  private

  def permitted_params
    params.require(:salary).permit(
      :salary_range,
      :max_amount,
      :min_amount,
      :calculation_basis
    )
  end
end
