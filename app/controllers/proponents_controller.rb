class ProponentsController < ApplicationController
  before_action :set_proponent, only: %i[show edit update]

  def index
    @q = Proponent.ransack(params[:q])
    @proponents = @q.result(distinct: true).page(params[:page])
  end

  def show
    render(turbo_stream: turbo_stream.send('update', proponent, partial: 'proponent', locals: { proponent: }))
  end

  def new
    @proponent = Proponent.new
  end

  def edit; end

  def create
    @proponent = Proponent.new(permitted_params)

    return redirect_to proponents_path, notice: t('.success') if proponent.save

    render(turbo_stream: turbo_stream.send('update', proponent, partial: 'form', locals: { proponent: }))
  end

  def update
    if proponent.update(permitted_params)
      redirect_to proponents_path, notice: t('.success')
    else
      render(turbo_stream: turbo_stream.send('replace', proponent, partial: 'form', locals: { proponent: }))
    end
  end

  def calculate_discount
    render(
      json: {
        data: Proponent::Discount.call(
          Proponent.new(
            gross_salary: params[:gross_salary]
          )
        )
      }
    )
  end

  private

  attr_reader :proponents, :proponent

  def set_proponent
    @proponent = Proponent.find(params.require(:id))
  end

  def permitted_params
    params.require(:proponent).permit(
      :gross_salary,
      :name,
      :document,
      :birth_date,
      :address_id,
      :phone_id
    )
  end
end
