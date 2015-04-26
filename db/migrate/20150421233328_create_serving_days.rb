class CreateServingDays < ActiveRecord::Migration
  def change
    create_table :serving_days do |t|
      t.references :maid, null: false, index: true
      t.references :picture, null: false, index: true
      t.date :date, null: false
      t.time :start_time
      t.time :end_time
      t.integer :location, default: 0, null: false
      t.timestamps null: false
    end
  end
end
