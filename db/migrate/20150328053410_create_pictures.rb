class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :tweet, null: false, index: true
      t.string :url, null: false
      t.timestamps null: false
    end
  end
end
