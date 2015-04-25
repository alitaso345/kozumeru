class AddPostIdToPictures < ActiveRecord::Migration
  def up
    add_column :pictures, :post_id, :integer

    remove_column :pictures, :blog_id
    add_column :pictures, :blog_id, :integer
  end

  def down
    remove_column :pictures, :post_id

    remove_column :pictures, :blog_id
    add_column :pictures, :blog_id, :integer, null: false
  end
end
