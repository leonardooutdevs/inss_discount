class ProponentsController < ApplicationController
  before_action :set_proponent, only: %i[show edit update]

  def index
    @q = scope.ransack(params[:q])
    @proponents = q.result(distinct: true).page(params[:page])
    authorize(proponents)
  end

  def show
    render(turbo_stream: turbo_stream.send('update', proponent, partial: 'proponent', locals: { proponent: }))
  end

  def new
    @proponent = authorize(scope.new)
    proponent.proponent_addresses.build.build_address
    proponent.proponent_phones.build.build_phone
  end

  def edit
    proponent.proponent_addresses.build.build_address if addresses.blank?
    proponent.proponent_phones.build.build_phone if phones.blank?
  end

  def create
    @proponent = authorize(scope.new(permitted_params))

    return redirect_to proponents_path, notice: t('.success') if proponent.save

    render(turbo_stream: turbo_stream.send('update', proponent, partial: 'form', locals: { proponent: }))
  end

  def update
    if proponent.update(permitted_params)
      redirect_to edit_proponent_path(proponent), notice: t('.success')
    else
      render(turbo_stream: turbo_stream.send('replace', proponent, partial: 'form', locals: { proponent: }))
    end
  end

  private

  attr_reader :proponents, :proponent, :q

  delegate :addresses, :phones, to: :proponent, allow_nil: true

  def scope = policy_scope(Proponent)

  def set_proponent
    @proponent = authorize(scope.find(params.require(:id)))
  end

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
