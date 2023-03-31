class Api::V1::SleepSchedulesController < ApplicationController
  before_action :set_schedule, only: %i[destroy update]
  before_action :convert_time_schedule, only: %i[create update]

  def index
    @schedules = SleepSchedule.all.order(:created_at)
    @schedules = @schedules.by_user(params[:sleep_schedule][:user_id]) if params[:sleep_schedule][:user_id]

    render json: { schedules: @schedules.as_json(only: %i[id], methods: %i[owner sleep_time_hour wake_time_hour]), status: :ok }
  end

  def create
    user = User.find_by(name: params[:sleep_schedule][:user_name])
    user = create_new_user if user.nil?

    schedule = SleepSchedule.new(sleep_schedule_params)
    schedule.user_id = user.id

    if schedule.save
      render json: { schedule: schedule.as_json(only: %i[id], methods: %i[sleep_time_hour wake_time_hour]), status: 200 }
    else
      render json: schedule.errors, status: :unprocessable_entity
    end
  end

  def update
    @schedule.update(sleep_schedule_params)

    render json: { schedule: @schedule.as_json(only: %i[id], methods: %i[sleep_time_hour wake_time_hour]), status: 200 }
  rescue StandardError => exception
    render json: { message: exception.message, status: 401 }
  end

  def destroy
    binding.pry
    @schedule.update(active: false)

    render json: {}, status: 200
  rescue StandardError => exception
    render json: { message: exception.message, status: 401 }
  end

  private

  def sleep_schedule_params
    params.require(:sleep_schedule).permit(:sleep_time, :wake_time, :user_name)
  end

  def create_new_user
    User.create(name: params[:sleep_schedule][:user_name])
  end

  def set_schedule
    binding.pry
    @schedule = SleepSchedule.find(params[:id])
  end

  def convert_time_schedule
    params[:sleep_schedule][:sleep_time] = DateTime.parse(sleep_schedule_params[:sleep_time])
    params[:sleep_schedule][:wake_time] = DateTime.parse(sleep_schedule_params[:wake_time]) + 1.day
  end
end
