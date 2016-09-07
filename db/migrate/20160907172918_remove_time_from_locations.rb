class RemoveTimeFromLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :time, :datetime
  end
end
