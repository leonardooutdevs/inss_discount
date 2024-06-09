class AccessPermissionsController < ApplicationController
  before_action :set_access_permission, only: %i[show edit update destroy]
  before_action :set_access_levels

  def index
    @q = scope.includes(:access_levels).ransack(params[:q])
    @access_permissions = q.result(distinct: true).page(params[:page])
    authorize(access_permissions)
  end

  def show
    render_turbo('access_permission')
  end

  def new
    @access_permission = authorize(scope.new)
    render_turbo('form', 'prepend', 'access_permissions')
  end

  def edit
    render_turbo('form')
  end

  def create
    @access_permission = authorize(scope.new(permitted_params))

    if access_permission.save
      render_turbo('access_permission', 'update', scope.new)
    else
      render_turbo('form')
    end
  end

  def update
    if access_permission.update(permitted_params)
      render_turbo('access_permission')
    else
      render_turbo('form')
    end
  end

  def destroy
    authorize(access_permission).destroy!
    render turbo_stream: turbo_stream.remove(access_permission)
  end

  private

  attr_reader :access_permissions, :access_permission, :q, :access_levels

  def scope = policy_scope(AccessPermission)

  def render_turbo(partial, action = 'update', target = access_permission)
    render(
      turbo_stream: turbo_stream
      .send(
        action,
        target,
        partial:,
        locals: { access_permission:, access_levels: }
      )
    )
  end

  def set_access_permission
    @access_permission = authorize(scope.includes(:access_levels).find(params.require(:id)))
  end

  def set_access_levels
    @access_levels = AccessLevel.all
  end

  def permitted_params
    params.require(:access_permission).permit(:name, :model)
  end
end
