class StatesController < ApplicationController
  before_action :set_state, only: %i[show edit update]

  def index
    @q = scope.eager_load(:country).ransack(params[:q])
    @states = q.result(distinct: true).page(params[:page])
    authorize(states)
  end

  def show
    render(turbo_stream: turbo_stream.send('update', state, partial: 'state', locals: { state: }))
  end

  def edit
    render(turbo_stream: turbo_stream.send('replace', state, partial: 'form', locals: { state: }))
  end

  def update
    if state.update(permitted_params)
      render(turbo_stream: turbo_stream.send('replace', state, partial: 'state', locals: { state: }))
    else
      render(turbo_stream: turbo_stream.send('replace', state, partial: 'form', locals: { state: }))
    end
  end

  private

  attr_reader :states, :state, :q

  def scope = policy_scope(State)

  def set_state
    @state = authorize(scope.find(params.require(:id)))
  end

  def permitted_params
    params.require(:state).permit(:name)
  end
end
