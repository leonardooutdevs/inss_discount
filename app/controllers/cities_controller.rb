class CitiesController < ResourcefulController
  resourceful only: %i[index show edit update]

  def index
    index_resourceful do
      @q = City.eager_load(state: :country).ransack(params[:q])
    end
  end

  private

  def permitted_params
    params.require(:city).permit(:name)
  end
end
