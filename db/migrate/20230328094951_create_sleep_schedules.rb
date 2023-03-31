class CreateSleepSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :sleep_schedules do |t|
      t.references :user, index: true, foreign_key: true
      t.timestamp :sleep_time, null: false
      t.timestamp :wake_time, null: false
      t.boolean :active, default: 1, null: false

      t.timestamps
    end
  end
end
