module Users
  class AccessPermissionLevelsController < ApplicationController
    before_action :set_user

    def index
      @access_permission_levels = authorize(fetch_access_permission_levels)
    end

    attr_reader :q, :access_permission_levels, :user

    def set_user
      @user = policy_scope(User).find(params.require(:user_id))
    end

    def fetch_access_permission_levels
      @q = user.access_permission_levels
               .select('access_permission_levels.*, access_permissions.name, access_permissions.model')
               .with_access_permission
               .order('access_permissions.name asc')
               .ransack(params[:q])

      q.result(distinct: true).page(params[:page]).per(params[:per])
    end
  end
end
