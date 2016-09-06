class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.datetime :time
      t.decimal :longitude, precision: 9, scale: 6
      t.decimal :latitude, precision: 9, scale: 6
      t.integer :user_id
      
      t.timestamps null: false
    end
    add_index :locations, :user_id
  end
end
