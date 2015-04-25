class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.references :maid, null: false, index: true
      t.string :title, null: false
      t.string :url, null: false
      t.timestamps null: false
    end

    add_index :blogs, :url, :unique => true
  end
end
