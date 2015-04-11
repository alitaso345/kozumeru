class RenameColumnMaidsMaidsNumberToNumber < ActiveRecord::Migration
  def change
    rename_column :maids, :maidnumber, :number
  end
end
