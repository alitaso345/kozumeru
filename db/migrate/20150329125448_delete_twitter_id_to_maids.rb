class DeleteTwitterIdToMaids < ActiveRecord::Migration
  def change
    remove_column :maids, :twitter_id
  end
end
