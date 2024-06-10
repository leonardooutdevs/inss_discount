class AccessLevelsController < ApplicationController
  before_action :set_access_level, only: %i[show edit update destroy]

  def index
    @q = scope.ransack(params[:q])
    @access_levels = q.result(distinct: true).page(params[:page])
    authorize(access_levels)
  end

  def show
    render_turbo('access_level')
  end

  def new
    @access_level = authorize(scope.new)
    render_turbo('form', 'prepend', 'access_levels')
  end

  def edit
    render_turbo('form')
  end

  def create
    @access_level = authorize(scope.new(permitted_params))

    if access_level.save
      render_turbo('access_level', 'update', scope.new)
    else
      render_turbo('form')
    end
  end

  def update
    if access_level.update(permitted_params)
      render_turbo('access_level')
    else
      render_turbo('form')
    end
  end

  def destroy
    access_level.destroy!
    render turbo_stream: turbo_stream.remove(access_level)
  end

  private

  attr_reader :access_levels, :access_level, :q

  def scope = policy_scope(AccessLevel)

  def render_turbo(partial, action = 'update', target = access_level)
    render(
      turbo_stream: turbo_stream
      .send(
        action,
        target,
        partial:,
        locals: { access_level: }
      )
    )
  end

  def set_access_level
    @access_level = authorize(scope.find(params.require(:id)))
  end

  def permitted_params
    params.require(:access_level).permit(:name, :kind)
  end
end
