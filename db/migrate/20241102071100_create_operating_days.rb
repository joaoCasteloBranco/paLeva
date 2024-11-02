class CreateOperatingDays < ActiveRecord::Migration[7.2]
  def change
    create_table :operating_days do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.integer :week_day
      t.boolean :open
      t.time :opening_time
      t.time :closing_time

      t.timestamps
    end
  end
end
