class AddIndexTwitterAccountsUidUnique < ActiveRecord::Migration
  def change
    add_index :twitter_accounts, [:uid, :screen_name], :unique => true
  end
end
