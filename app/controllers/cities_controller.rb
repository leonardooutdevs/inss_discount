class CitiesController < ApplicationController
  before_action :set_city, only: %i[show edit update]

  def index
    @q = City.eager_load(state: :country).ransack(params[:q])
    @cities = @q.result(distinct: true).page(params[:page])
  end

  def show
    render(turbo_stream: turbo_stream.send('update', city, partial: 'city', locals: { city: }))
  end

  def edit
    render(turbo_stream: turbo_stream.send('replace', city, partial: 'form', locals: { city: }))
  end

  def update
    if city.update(permitted_params)
      render(turbo_stream: turbo_stream.send('replace', city, partial: 'city', locals: { city: }))
    else
      render(turbo_stream: turbo_stream.send('replace', city, partial: 'form', locals: { city: }))
    end
  end

  private

  attr_reader :cities, :city

  def set_city
    @city = City.find(params.require(:id))
  end

  def permitted_params
    params.require(:city).permit(:email)
  end
end
