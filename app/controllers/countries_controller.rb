class CountriesController < ResourcefulController
  resourceful only: %i[index show edit update], turbo: true

  private

  def permitted_params
    params.require(:country).permit(:name)
  end
end
