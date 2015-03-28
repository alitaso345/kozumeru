class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.references :twitter_account, null: false, index: true
      t.text :text, null: false
      t.string :status_id, null: false
      t.datetime :published_at, null: false
      t.timestamps null: false
    end
  end
end
