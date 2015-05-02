class ChangeServingDaysPictureIdToNullTrue < ActiveRecord::Migration
  def up
    remove_column :serving_days, :picture_id
    add_column :serving_days, :picture_id, :integer
    add_index :serving_days, :picture_id
  end

  def down
  end
end
