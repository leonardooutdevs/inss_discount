class AccessLevelsController < ApplicationController
  before_action :set_access_level, only: %i[show edit update]

  def index
    @q = AccessLevel.ransack(params[:q])
    @access_levels = q.result(distinct: true).page(params[:page])
  end

  def show
    render_turbo('access_level')
  end

  def edit
    render_turbo('form')
  end

  def update
    if access_level.update(permitted_params)
      render_turbo('access_level')
    else
      render_turbo('form')
    end
  end

  private

  attr_reader :access_levels, :access_level, :q

  def render_turbo(partial)
    render(turbo_stream: turbo_stream.send('update', access_level, partial:, locals: { access_level: }))
  end

  def set_access_level
    @access_level = AccessLevel.find(params.require(:id))
  end

  def permitted_params
    params.require(:access_level).permit(:name, :kind)
  end
end
