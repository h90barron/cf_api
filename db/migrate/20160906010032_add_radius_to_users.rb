class AddRadiusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :radius, :integer
  end
end
