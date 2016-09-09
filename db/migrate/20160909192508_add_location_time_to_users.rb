class AddLocationTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :location_time, :datetime
  end
end
