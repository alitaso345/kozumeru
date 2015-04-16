class AddGraduatedToMaids < ActiveRecord::Migration
  def change
    add_column :maids, :graduated, :integer, :null => false, :default => 0
  end
end
