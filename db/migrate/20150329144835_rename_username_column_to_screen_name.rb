class RenameUsernameColumnToScreenName < ActiveRecord::Migration
  def change
    rename_column :twitter_accounts, :username, :screen_name
  end
end
