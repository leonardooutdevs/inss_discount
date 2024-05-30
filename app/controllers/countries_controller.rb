class CountriesController < ApplicationController
  before_action :set_country, only: %i[show edit update]

  def index
    @q = Country.ransack(params[:q])
    @countries = @q.result(distinct: true).page(params[:page])
  end

  def show
    render(turbo_stream: turbo_stream.send('update', country, partial: 'country', locals: { country: }))
  end

  def edit
    render(turbo_stream: turbo_stream.send('replace', country, partial: 'form', locals: { country: }))
  end

  def update
    if country.update(permitted_params)
      render(turbo_stream: turbo_stream.send('replace', country, partial: 'country', locals: { country: }))
    else
      render(turbo_stream: turbo_stream.send('replace', country, partial: 'form', locals: { country: }))
    end
  end

  private

  attr_reader :countries, :country

  def set_country
    @country = Country.find(params.require(:id))
  end

  def permitted_params
    params.require(:country).permit(:name)
  end
end
