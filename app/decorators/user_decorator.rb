class UserDecorator < ApplicationDecorator
  def pending_permissions
    AccessPermission.all - access_permissions
  end
end
