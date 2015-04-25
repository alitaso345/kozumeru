class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.references :maid, null: false, index: true
      t.string :title, null: false
      t.string :account_name, null: false
      t.timestamps null: false
    end

    add_index :blogs, :account_name, :unique => true
  end
end
