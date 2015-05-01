class ChangeClumnMiadNumberToInteger < ActiveRecord::Migration
  def change
    change_column :maids, :number, :integer, :null => false
  end
end
