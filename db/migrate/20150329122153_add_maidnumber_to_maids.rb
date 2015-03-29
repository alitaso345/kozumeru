class AddMaidnumberToMaids < ActiveRecord::Migration
  def up
    add_column :maids, :maidnumber, :string
    change_column :maids, :maidnumber, :string, {null: false}
  end

  def down
    remove_column :maids, :maidnumber
  end
end
