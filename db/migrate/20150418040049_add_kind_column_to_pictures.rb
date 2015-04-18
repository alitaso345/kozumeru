class AddKindColumnToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :kind, :integer
  end
end
