class AddPostIdToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :post_id, :integer
    add_index :pictures, :post_id
  end
end
