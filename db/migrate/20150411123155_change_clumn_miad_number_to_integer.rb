class ChangeClumnMiadNumberToInteger < ActiveRecord::Migration
  def change
    change_column :maids, :number, 'integer USING CAST(number AS integer)', :null => false
  end
end
