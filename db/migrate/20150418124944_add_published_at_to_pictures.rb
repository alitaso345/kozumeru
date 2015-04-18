class AddPublishedAtToPictures < ActiveRecord::Migration
  def up
    add_column :pictures, :published_at, :date
    change_column :pictures, :published_at, :datetime, {null: false}
  end

  def down
    remove_column :pictures, :published_at
  end
end
