class UsersController < ResourcefulController
  resourceful only: %i[index show edit update]

  private

  def permitted_params
    params.require(:user).permit(:email)
  end
end
