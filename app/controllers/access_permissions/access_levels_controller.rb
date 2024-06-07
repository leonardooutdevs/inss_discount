module AccessPermissions
  class AccessLevelsController < ApplicationController
    before_action :set_access_permission
    before_action :set_access_level

    def create
      access_permission.access_levels << access_level
      render_turbo
    end

    def destroy
      access_permission.access_levels.delete(access_level)
      render_turbo
    end

    private

    attr_reader :access_permission, :access_level

    def render_turbo
      render(
        turbo_stream: turbo_stream
        .send(
          'update',
          access_permission,
          partial: '/access_permissions/access_permission',
          locals: { access_permission:, access_levels: AccessLevel.order_by_kind }
        )
      )
    end

    def set_access_permission
      @access_permission = AccessPermission
                           .includes(:access_levels)
                           .find(params.require(:access_permission_id))
    end

    def set_access_level
      @access_level = AccessLevel.find(params.require(:id))
    end
  end
end
