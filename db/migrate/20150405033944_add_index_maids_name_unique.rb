class AddIndexMaidsNameUnique < ActiveRecord::Migration
  def change
    add_index :maids, [:name, :maidnumber], :unique => true
  end
end
