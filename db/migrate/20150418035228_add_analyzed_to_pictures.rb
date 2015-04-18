class AddAnalyzedToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :analyzed, :boolean, :null => false, :default => false 
  end
end
