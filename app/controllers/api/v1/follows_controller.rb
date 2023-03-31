class Api::V1::FollowsController < ApplicationController
  before_action :set_current_user

  def create
    user = User.find(params[:follower_id])
    @current_user.following_users.create(follower_id: user.id)

    render json: @current_user.as_json(only: %i[id]), status: :ok
  rescue StandardError => exception
    render json: { message: exception.message, status: 401 }
  end

  def destroy
    user = Follow.find(params[:id]).follower
    @current_user.following_users.find_by(follower_id: user.id).destroy

    render json: @current_user.as_json(only: %i[id]), status: :ok
  rescue StandardError => exception
    render json: { message: exception.message, status: 401 }
  end

  private

  def set_current_user
    @current_user = User.find(params[:followee_id])
  end
end
