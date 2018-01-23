class AddPoint1ToSpot < ActiveRecord::Migration[5.1]
  def change
    add_column :spots, :point1, :text
    add_column :spots, :point2, :text
    add_column :spots, :point3, :text
  end
end
