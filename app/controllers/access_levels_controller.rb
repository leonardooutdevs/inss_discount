class AccessLevelsController < ResourcefulController
  resourceful turbo: true,
              decorate: true

  private

  def permitted_params
    params.require(:access_level).permit(:name, :kind)
  end
end
