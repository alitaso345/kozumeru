class AddIndexTweetsStatusIdUnique < ActiveRecord::Migration
  def change
    add_index :tweets, :status_id, :unique => true
  end
end
