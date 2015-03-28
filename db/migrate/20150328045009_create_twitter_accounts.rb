class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.string :uid, null: false
      t.string :username, null: false
      t.references :maid, null: false, index: true
      t.timestamps null: false
    end
  end
end
