class ChangeTweetIdIndex < ActiveRecord::Migration
  def up
    remove_column :pictures, :tweet_id
    add_column :pictures, :tweet_id, :integer
    add_index :pictures, :tweet_id
  end

  def down
    remove_column :pictures, :tweet_id
    add_column :pictures, :tweet_id, :integer
    remove_index :pictures, :tweet_id
  end
end
