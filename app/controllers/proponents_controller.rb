class ProponentsController < ApplicationController
  before_action :set_proponent, only: %i[show edit update]

  def index
    @q = Proponent.ransack(params[:q])
    @proponents = @q.result(distinct: true).page(params[:page])
  end

  def show
    render(turbo_stream: turbo_stream.send('update', proponent, partial: 'proponent', locals: { proponent: }))
  end

  def edit
    render(turbo_stream: turbo_stream.send('replace', proponent, partial: 'form', locals: { proponent: }))
  end

  def update
    if proponent.update(permitted_params)
      render(turbo_stream: turbo_stream.send('replace', proponent, partial: 'proponent', locals: { proponent: }))
    else
      render(turbo_stream: turbo_stream.send('replace', proponent, partial: 'form', locals: { proponent: }))
    end
  end

  private

  attr_reader :proponents, :proponent

  def set_proponent
    @proponent = Proponent.find(params.require(:id))
  end

  def permitted_params
    params.require(:proponent).permit(:name)
  end
end
