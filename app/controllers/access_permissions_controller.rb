class AccessPermissionsController < ApplicationController
  before_action :set_access_permission, only: %i[show edit update]
  before_action :set_access_levels

  def index
    @q = AccessPermission.includes(:access_levels).ransack(params[:q])
    @access_permissions = q.result(distinct: true).page(params[:page])
  end

  def show
    render_turbo('access_permission')
  end

  def edit
    render_turbo('form')
  end

  def update
    if access_permission.update(permitted_params)
      render_turbo('access_permission')
    else
      render_turbo('form')
    end
  end

  private

  attr_reader :access_permissions, :access_permission, :q, :access_levels

  def render_turbo(partial)
    render(
      turbo_stream: turbo_stream
      .send(
        'update',
        access_permission,
        partial:,
        locals: { access_permission:, access_levels: }
      )
    )
  end

  def set_access_permission
    @access_permission = AccessPermission.includes(:access_levels).find(params.require(:id))
  end

  def set_access_levels
    @access_levels = AccessLevel.order_by_kind
  end

  def permitted_params
    params.require(:access_permission).permit(:name, :model)
  end
end
