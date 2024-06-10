class StatesController < ResourcefulController
  resourceful only: %i[index show edit update], turbo: true

  private

  def permitted_params
    params.require(:state).permit(:name)
  end
end
