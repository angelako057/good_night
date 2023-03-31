class Api::V1::UsersController < ApplicationController
  def index
    user = User.find_by(name: params[:user_name])
    records = SleepSchedule.by_user(user.following_users.pluck(:follower_id)).by_past_week
                  &.as_json(only: %i[id], methods: %i[owner alarm_date sleep_time_hour wake_time_hour total_sleep_hour])
                  .sort_by { |record| record['total_sleep_hour'] }.reverse

    render json: { user_id: user.id, records: }, status: :ok
  end

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
