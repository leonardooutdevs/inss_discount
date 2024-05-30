class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page])
  end

  def show
    render(turbo_stream: turbo_stream.send('update', user, partial: 'user', locals: { user: }))
  end

  def edit
    render(turbo_stream: turbo_stream.send('replace', user, partial: 'form', locals: { user: }))
  end

  def update
    if user.update(permitted_params)
      render(turbo_stream: turbo_stream.send('replace', user, partial: 'user', locals: { user: }))
    else
      render(turbo_stream: turbo_stream.send('replace', user, partial: 'form', locals: { user: }))
    end
  end

  private

  attr_reader :users, :user

  def set_user
    @user = User.find(params.require(:id))
  end

  def permitted_params
    params.require(:user).permit(:email)
  end
end
