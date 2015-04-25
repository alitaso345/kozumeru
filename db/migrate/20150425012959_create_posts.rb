class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :blog, null: false, index: true
      t.string :url, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.datetime :published_at, null: false
      t.timestamps null: false
    end

    add_index :posts, :url, :unique => true
  end
end
