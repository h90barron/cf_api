class AddLatitudeAndLongitudeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :latitude, :decimal, {:precision=>10, :scale=>6}
    add_column :users, :longitude, :decimal, {:precision=>10, :scale=>6}
  end
end
