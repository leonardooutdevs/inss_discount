class AccessLevelPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  def index? = access_permission_level.superadmin?
  def show? = access_permission_level.superadmin?
  def create? = access_permission_level.superadmin?
  def new? = access_permission_level.superadmin?
  def update? = access_permission_level.superadmin?
  def edit? = access_permission_level.superadmin?
  def destroy? = access_permission_level.superadmin?

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
