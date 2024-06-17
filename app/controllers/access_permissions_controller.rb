class AccessPermissionsController < ResourcefulController
  resourceful turbo: true

  before_action :set_access_levels

  private

  def permitted_params
    params.require(:access_permission).permit(:name, :model)
  end

  def set_access_levels
    @access_levels = AccessLevel.all
  end

  def locals = { access_permission:, access_levels: }
end
