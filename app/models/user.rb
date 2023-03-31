class User < ApplicationRecord
  has_many :sleep_schedules, foreign_key: :user_id

  validates :name, presence: true
end
