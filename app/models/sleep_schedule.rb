class SleepSchedule < ApplicationRecord
  default_scope { where(active: true) }

  belongs_to :user

  validates :user_id, :sleep_time, :wake_time, presence: true

  scope :by_user, -> (user_id) { where(user_id:) }
  scope :by_past_week, -> { where('created_at >= ? and created_at <= ?', (Date.current - 1.week).beginning_of_day, Date.current.end_of_day) }

  attr_accessor :user_name

  def sleep_time_hour
    sleep_time.strftime("%I:%M %p")
  end

  def wake_time_hour
    wake_time.strftime("%I:%M %p")
  end

  def total_sleep_hour
    (wake_time.to_time - sleep_time.to_time) / 1.hour
  end

  def owner
    user.name
  end

  def alarm_date
    sleep_time.to_date
  end
end
