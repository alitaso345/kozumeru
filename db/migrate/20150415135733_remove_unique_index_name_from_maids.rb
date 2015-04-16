class RemoveUniqueIndexNameFromMaids < ActiveRecord::Migration
  def self.up
    remove_index :maids, :column => [:name, :number]
    add_index :maids, :number, :unique => true 
  end

  def self.down
    remove_index :maids, :column => [:number]
    add_index :maids, [:name, :number], :unique => true
  end
end
