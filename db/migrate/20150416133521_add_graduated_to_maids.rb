class AddGraduatedToMaids < ActiveRecord::Migration
  def change
    add_column :maids, :graduated, :boolean, :null => false, :default => false
  end
end
