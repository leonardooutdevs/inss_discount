module Users
  class UserAccessesController < ApplicationController
    include ActionView::RecordIdentifier

    before_action :set_user
    before_action :set_user_access, only: :update

    def create
      @user_access = authorize(user.user_accesses.new(access_permission_level:))

      user_access.save!
      render_prepend_turbo
    end

    def update
      authorize(user_access).update(access_permission_level: new_access_permission_level)

      render_turbo
    end

    private

    attr_reader :user, :user_access

    def set_user
      @user = policy_scope(User).find(params.require(:user_id))
    end

    def set_user_access
      @user_access = policy_scope(user.user_accesses).find(params.require(:id))
    end

    def new_access_permission_level
      @new_access_permission_level ||=
        policy_scope(AccessPermissionLevel)
        .find_by!(
          access_permission_id: access_permission_level.access_permission_id,
          access_level_id: params.require(:access_level_id)
        )
    end

    def access_permission_level = policy_scope(AccessPermissionLevel).find(params.require(:access_permission_level_id))

    def render_prepend_turbo
      render(
        turbo_stream: turbo_stream
        .send(
          'prepend',
          'access_permission_levels',
          partial: '/users/access_permission_levels/access_permission_level',
          locals: { access_permission_level:, user: user.reload }
        )
      )
    end

    def render_turbo
      render(
        turbo_stream: turbo_stream
        .send(
          'update',
          dom_id(user, access_permission_level.id),
          partial: '/users/access_permission_levels/access_permission_level',
          locals: { access_permission_level: new_access_permission_level, user: user.reload }
        )
      )
    end
  end
end
