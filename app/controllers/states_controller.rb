class StatesController < ResourcefulController
  resourceful only: %i[index show edit update]

  private

  def permitted_params
    params.require(:state).permit(:name)
  end
end
