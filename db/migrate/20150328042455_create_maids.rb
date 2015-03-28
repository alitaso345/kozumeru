class CreateMaids < ActiveRecord::Migration
  def change
    create_table :maids do |t|
      t.string :name, null: false
      t.string :floor
      t.string :twitter_id
      t.timestamps null: false
    end
  end
end
