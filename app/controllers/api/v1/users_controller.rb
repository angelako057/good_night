class Api::V1::UsersController < ApplicationController

  def create
    user = User.create(user_params)

    render json: user.as_json(only: %i[name]), status: :ok
  rescue StandardError => exception
    render json: { message: exception.message, status: 401 }
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
